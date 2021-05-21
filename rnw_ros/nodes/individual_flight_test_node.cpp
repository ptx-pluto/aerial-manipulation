#include "rnw_ros/drone_interface.h"

#include <Eigen/Dense>
#include <uav_utils/converters.h>
#include <rnw_ros/traj_uitls.h>
#include <am_traj/am_traj.hpp>
#include <am_traj/ros_msgs.h>

using std::vector;
using Eigen::Vector2d;
using Eigen::Vector3d;
using Eigen::Matrix3d;


Vector3d point_in_frame( nav_msgs::Odometry const & odom, Vector3d const & pt ){
  Matrix3d R = uav_utils::from_quaternion_msg(odom.pose.pose.orientation).toRotationMatrix();
  Vector3d T = uav_utils::from_point_msg(odom.pose.pose.position);
  return R*pt + T;
}

struct individual_drone_test_t {

    ros::NodeHandle & nh;

    drone_interface_t drone;

    ros::Subscriber sub_trigger_zigzag;

    AmTraj traj_generator;

    explicit individual_drone_test_t(ros::NodeHandle & _nh ) : nh(_nh), traj_generator(1024, 16, 0.4, 1, 0.5, 23, 0.02) {

      drone.init(get_ros_param_required<string>(nh,"drone_name"));

      sub_trigger_zigzag = nh.subscribe<std_msgs::Header>(
              "/gamepad/X", 10, &individual_drone_test_t::trigger_zigzag, this);

    }

    /**
     * Waypoints in world frame to Polynomial Trajectory
     * @param odom - local frame
     * @param wpts - waypoints in world frame
     * @return
     */
    quadrotor_msgs::PolynomialTrajectory wpts2traj( nav_msgs::Odometry const & odom, std::vector<Eigen::Vector3d> const & wpts ) const {
      Vector3d v0 = Vector3d::Zero();
      Trajectory traj = traj_generator.genOptimalTrajDTC(wpts, v0, v0, v0, v0);
      return to_ros_msg(traj,odom,ros::Time::now());
    }

    /**
     * Waypoints in local frame to polynomial trajectory
     * @param odom - local frame
     * @param wpts - waypoints in local frame
     * @return
     */
    quadrotor_msgs::PolynomialTrajectory local_wpts2traj( nav_msgs::Odometry const & odom, vector<Vector3d> const & wpts ) const {
      Matrix3d R = uav_utils::from_quaternion_msg(odom.pose.pose.orientation).toRotationMatrix();
      Vector3d T = uav_utils::from_point_msg(odom.pose.pose.position);
      return wpts2traj(odom,transform_pts(wpts,R,T));
    }

    void trigger_zigzag( std_msgs::HeaderConstPtr const & msg ) const {

      if ( !drone.ready(true) ) {
        return;
      }

      vector<Vector3d> wpts = gen_waypoint_zigzag(5,0.5,0.5);

      drone.execute_trajectory(local_wpts2traj(drone.latest_odom, wpts));

    }

};

int main( int argc, char** argv ) {

  ros::init(argc,argv,"individual_flight_test_node");

  ros::NodeHandle nh("~");

  individual_drone_test_t node(nh);

  ros::spin();

  ros::shutdown();

  return 0;

}