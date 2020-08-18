//
// Created by sheep on 2020/8/6.
//

#ifndef SRC_RNW_UTILS_H
#define SRC_RNW_UTILS_H

#include "rnw_ros/ros_utils.h"

struct rnw_config_t {

    Vector3d X_tip_body;

    Vector3d X_tcp_cage;

    double hover_above_tip;

    double insert_below_tip;

    inline void load_from_ros( ros::NodeHandle & nh ){

      X_tip_body.x() = get_param_default(nh,"X_tip_body/x",0.);
      X_tip_body.y() = get_param_default(nh,"X_tip_body/y",0.);
      X_tip_body.z() = get_param_default(nh,"X_tip_body/z",0.);

      X_tcp_cage.x() = get_param_default(nh,"X_tcp_cage/x",0.);
      X_tcp_cage.y() = get_param_default(nh,"X_tcp_cage/y",0.);
      X_tcp_cage.z() = get_param_default(nh,"X_tcp_cage/z",0.);

      hover_above_tip = get_param_default(nh,"hover_above_tip",5.);
      insert_below_tip = get_param_default(nh,"insert_below_tip",5.);

    }

};

/**
 * insertion waypoints in the local frame of the cone tip
 * @param hover_above
 * @param insert_below
 * @param head_room
 * @param topple_forward
 * @return
 */
inline vector<Vector3d> gen_topple_waypoints_local(
        double hover_above = 0.05,
        double insert_below = 0.03,
        double head_room = 0.2,
        double topple_forward = 0.2 )
{
  vector<Vector3d> wpts;
  wpts.emplace_back(head_room,0,hover_above); // ahead
  wpts.emplace_back(0,0,hover_above); // above tip
  wpts.emplace_back(0,0,0); // tip point
  wpts.emplace_back(0,0,-insert_below); // inserted
  wpts.emplace_back(topple_forward,0,-insert_below-0.03); // toppled
  return wpts;
}

#endif //SRC_RNW_UTILS_H
