//
// Created by sheep on 2020/8/6.
//

#ifndef SRC_RNW_UTILS_H
#define SRC_RNW_UTILS_H

#include <deque>
#include <quadrotor_msgs/Float64Stamped.h>
#include <rnw_msgs/ConeState.h>
#include <nav_msgs/Odometry.h>
#include <rnw_msgs/GripState.h>
#include <rnw_msgs/RockingCmd.h>

#include "rnw_ros/rnw_config.h"

/**
 * For downward mounted caging end-effector
 * Waypoints for initialization, insert -> topple
 * @param rnw_config
 * @return
 */
vector<Vector3d> gen_wpts_insert_topple(rnw_config_t const & rnw_config );

/**
 * For forward mounted open cage, no insertion
 * @param rnw_config
 * @return
 */
vector<Vector3d> gen_wpts_push_topple( rnw_config_t const & rnw_config );

/**
 * x-psi-precession
 * y-theta-nutation (tilt)
 * z-phi-spin
 * @param R
 * @return - (x,y,z) - rad
 */
Vector3d cone_rot2euler( Matrix3d const & R );

/**
 * Distance between 3d line AB and 3d point C
 * See https://mathworld.wolfram.com/Point-LineDistance3-Dimensional.html
 * @param pt1 - A
 * @param pt2 - B
 * @param pt - C
 * @return distance
 */
double line_point_dist_3d( Vector3d const & A, Vector3d const & B, Vector3d const & C );

/**
 * Rodrigues' Rotation Formula
 * see https://en.wikipedia.org/wiki/Rodrigues%27_rotation_formula
 * rotate point X along axis (O+lambda*K), right-hand-rule theta
 * @param X - the point to rotate
 * @param O - origin of the rotation axis
 * @param K - unit normal vector of the rotation axis
 * @param theta - radiant
 * @return
 */
Vector3d rotate_point_along_axis( Vector3d const & X, Vector3d const & O, Vector3d const & K, double theta );

double dist( Vector3d const & A, Vector3d const & B );

inline double square( double val ){ return val*val; }

struct grip_state_t {

    grip_state_t();

    /**
     * Calculate the current grip state
     * @param cone_state
     * @param uav_odom
     * @param flu_T_tcp
     */
    grip_state_t(
            rnw_msgs::ConeState const & cone_state,
            nav_msgs::Odometry const & uav_odom,
            Vector3d const & flu_T_tcp
    );

    rnw_msgs::ConeState cone_state;

    nav_msgs::Odometry uav_odom;

    Vector3d flu_T_tcp;

    Vector3d grip_point;

    bool grip_valid = false;

    double grip_radius = 0;

    double grip_depth = 0;

    bool initialized = false;

    rnw_msgs::GripState to_msg() const;

};

grip_state_t calc_grip_state(
        rnw_msgs::ConeState const & _cone_state,
        nav_msgs::Odometry const & _uav_odom,
        Vector3d const & _flu_T_tcp
);

struct rnw_cmd_t {

    enum cmd_fsm_e {
        fsm_idle,
        fsm_pending,
        fsm_executing
    } fsm = fsm_idle;

    enum cmd_type_e {
        cmd_rocking,
        cmd_adjust_grip,
        cmd_adjust_nutation
    } cmd_type;

    /**
     * same cmd may be published multiple times, use this to keep track
     */
    size_t cmd_idx;

    grip_state_t grip_state;

    /**
     * where the uav need to move, this will:
     * 1. change nutation
     * 2. change grip depth
     * 3. rock the object
     */
    Vector3d setpoint_uav;

    ////////////////////////////////////////
    /// the above properties are enough for
    /// executing the command, the following
    /// properties are just for debug

    /// for cmd_adjust_grip

    double setpoint_nutation;

    double setpoint_grip_depth;

    Vector3d setpoint_apex;

    double tau_deg;

    size_t step_count;

    rnw_msgs::RockingCmd to_msg() const;

};

/**
 * Transform tip position to UAV position,
 * using downward mounted caging end-effector
 * @param tip
 * @param config
 * @return
 */
Vector3d tip_position_to_uav_position( Vector3d const & tip, rnw_config_t const & config );

/**
 * Desired TCP position to desired UAV position, all in world frame
 * @param tcp
 * @param uav_odom
 * @param flu_T_tcp
 * @return
 */
Vector3d tcp2uav( Vector3d const & tcp, nav_msgs::Odometry const & uav_odom, Vector3d const & flu_T_tcp );

/**
 * Calculate the desired TCP position under current cone_state at specific grip_depth
 * @param cone_state
 * @param grip_depth
 * @return tcp position
 */
Vector3d point_at_grip_depth( rnw_msgs::ConeState const & cone_state, double grip_depth );

template<typename T, size_t window_size>
struct median_filter_t {

    std::deque<T> values;

    median_filter_t() = default;

    T update( T val ){

      values.push_back(val);

      if ( values.size() > window_size ) {
        values.pop_front();
      }

      std::deque<T> sorted(values);
      std::sort(sorted.begin(),sorted.end());

      T output = sorted.at(sorted.size()/2);

      //ROS_INFO_STREAM("[median filter] input=" << val << ", output=" << output );

      return output;

    }

};

template<typename T, size_t window_size>
struct average_filter_t {

    std::deque<T> values;

    average_filter_t() = default;

    T update( T val ){

      values.push_back(val);

      if ( values.size() > window_size ) {
        values.pop_front();
      }

      T sum = 0;

      for ( auto v : values ) { sum+=v; }

      return sum/values.size();

    }

};

#endif //SRC_RNW_UTILS_H
