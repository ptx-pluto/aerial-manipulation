#include "rnw_ros/pose_utils.h"
#include <visualization_msgs/Marker.h>
#include <visualization_msgs/MarkerArray.h>
#include "rnw_msgs/ConeState.h"
#include "rnw_msgs/RockingCmd.h"

using namespace std;

struct cone_visualizer_t {

    double clear_after_n_sec = numeric_limits<double>::max();

    ros::Time latest_time;

    bool init = false;

    ros::Publisher pub_marker_cone;

    rnw_msgs::ConeState latest_cone_state;

    rnw_msgs::RockingCmd latest_rocking_cmd;

    static constexpr int id_base = 0;

    static constexpr int id_shaft = 1;

    static constexpr int id_contact_path = 2;

    static constexpr int id_contact_normal = 3;

    static constexpr int id_rocking_cmd = 4;

    string ns = "cone_state_visualization";

    double cone_color_r = 0;
    double cone_color_g = 0;
    double cone_color_b = 0;

    visualization_msgs::Marker marker_contact_path;

    explicit cone_visualizer_t( ros::NodeHandle & nh ) {
      pub_marker_cone = nh.advertise<visualization_msgs::MarkerArray>("markers/cone", 1);
      clear_after_n_sec = get_param_default(nh,"clear_after_n_sec",numeric_limits<double>::max());
      cone_color_r = get_param_default(nh,"cone_color_r",0);
      cone_color_g = get_param_default(nh,"cone_color_g",0);
      cone_color_b = get_param_default(nh,"cone_color_b",0);
      init_marker_contact_path();
    }

    void init_marker_contact_path(){
      marker_contact_path.id = id_contact_path;
      marker_contact_path.type = visualization_msgs::Marker::LINE_STRIP;
      marker_contact_path.header.stamp = ros::Time::now();
      marker_contact_path.header.frame_id = "world";
      marker_contact_path.action = visualization_msgs::Marker::ADD;
      marker_contact_path.ns = ns;
      marker_contact_path.color.r = 1;
      marker_contact_path.color.g = 0;
      marker_contact_path.color.b = 0;
      marker_contact_path.color.a = 1.00;
      marker_contact_path.pose.orientation.w = 1;
      marker_contact_path.scale.x = 0.01;
    }

    void on_cone_state( rnw_msgs::ConeStateConstPtr const & msg  ){
      latest_time = ros::Time::now();
      latest_cone_state = *msg;
      pub_marker_cone.publish(gen_markers());
      init = true;
    }

    void on_rocking_cmd( rnw_msgs::RockingCmdConstPtr const & msg ){
      latest_rocking_cmd = *msg;
    }

    visualization_msgs::MarkerArray gen_markers(){
      visualization_msgs::MarkerArray marker_arr;
      marker_arr.markers.push_back(gen_marker_base());
      marker_arr.markers.push_back(gen_marker_shaft());
      marker_arr.markers.push_back(gen_contact_path());
      marker_arr.markers.push_back(gen_marker_contact_normal());
      marker_arr.markers.push_back(gen_marker_rocking_cmd());
      return marker_arr;
    }

    visualization_msgs::Marker gen_marker_rocking_cmd() const {

      visualization_msgs::Marker marker;

      marker.id = id_rocking_cmd;
      marker.type = visualization_msgs::Marker::ARROW;
      marker.header.stamp = ros::Time::now();
      marker.header.frame_id = "world";
      marker.ns = ns;
      marker.scale.x = 0.01;
      marker.scale.y = 0.03;
      marker.scale.z = 0.1;
      marker.color.r = 1;
      marker.color.g = 0;
      marker.color.b = 0;
      marker.color.a = 1.00;
      marker.pose.orientation.w = 1;

      marker.action = visualization_msgs::Marker::ADD;
      marker.points.push_back(latest_cone_state.tip);
      marker.points.push_back(latest_rocking_cmd.tip_setpoint);

      if ( (latest_time - latest_rocking_cmd.header.stamp).toSec() > 0.5 ) {
        marker.action = visualization_msgs::Marker::DELETE;
      }

      return marker;

    }

    visualization_msgs::Marker gen_marker_contact_normal() const {

      visualization_msgs::Marker marker;

      marker.id = id_contact_normal;
      marker.type = visualization_msgs::Marker::ARROW;
      marker.header.stamp = ros::Time::now();
      marker.header.frame_id = "world";
      marker.ns = ns;
      marker.scale.x = 0.01;
      marker.scale.y = 0.03;
      marker.scale.z = 0.1;
      marker.color.r = 1;
      marker.color.g = 0;
      marker.color.b = 0;
      marker.color.a = 1.00;
      marker.pose.orientation.w = 1;

      if ( latest_cone_state.is_point_contact ) {
        marker.action = visualization_msgs::Marker::ADD;
        auto arrow_tip = latest_cone_state.contact_point;
        arrow_tip.z += 0.5;
        marker.points.push_back(latest_cone_state.contact_point);
        marker.points.push_back(arrow_tip);
      } else {
        marker.action = visualization_msgs::Marker::DELETE;
      }

      return marker;

    }

    visualization_msgs::Marker gen_marker_shaft() const {

      visualization_msgs::Marker marker;

      marker.id = id_shaft;
      marker.type = visualization_msgs::Marker::LINE_LIST;
      marker.header.stamp = ros::Time::now();
      marker.header.frame_id = "world";
      marker.action = visualization_msgs::Marker::ADD;
      marker.ns = ns;
      marker.color.r = cone_color_r;
      marker.color.g = cone_color_g;
      marker.color.b = cone_color_b;
      marker.color.a = 1.00;
      marker.pose.orientation.w = 1;
      marker.scale.x = 0.01;
      marker.points.push_back(latest_cone_state.base);
      marker.points.push_back(latest_cone_state.tip);
      return marker;
    }

    visualization_msgs::Marker gen_marker_base() const {

      visualization_msgs::Marker marker;

      marker.id = id_base;
      marker.type = visualization_msgs::Marker::CYLINDER;
      marker.header.stamp = ros::Time::now();
      marker.header.frame_id = "world";
      marker.action = visualization_msgs::Marker::ADD;
      marker.ns = ns;
      marker.color.r = cone_color_r;
      marker.color.g = cone_color_g;
      marker.color.b = cone_color_b;
      marker.color.a = 1.00;

      marker.pose.orientation = latest_cone_state.odom.pose.pose.orientation;
      marker.pose.position = latest_cone_state.disc_center;
      marker.scale.x = latest_cone_state.radius * 2;
      marker.scale.y = latest_cone_state.radius * 2;
      marker.scale.z = 0.01;

      return marker;

    }

    visualization_msgs::Marker gen_contact_path(){
      if ( latest_cone_state.is_point_contact ) {
        marker_contact_path.points.push_back(latest_cone_state.contact_point);
      }
      return marker_contact_path;
    }



    void clear_markers() const {
      visualization_msgs::MarkerArray accMarkers;
      visualization_msgs::Marker accMarker;
      accMarker.action = visualization_msgs::Marker::DELETEALL;
      accMarkers.markers.push_back(accMarker);
      pub_marker_cone.publish(accMarkers);
    }

    void on_spin( const ros::TimerEvent &event ){
      if ( !init ) { return; }
      if ( (ros::Time::now() - latest_time).toSec() > clear_after_n_sec ) {
        clear_markers();
      }
    }

};

int main( int argc, char** argv ) {

  ros::init(argc,argv,"visualize_cone_node");

  ros::NodeHandle nh("~");

  cone_visualizer_t cone_viz(nh);

  constexpr size_t spin_hz = 10;

  auto timer = nh.createTimer( ros::Duration( 1.0 / spin_hz ), &cone_visualizer_t::on_spin, &cone_viz );

  ros::Subscriber sub_traj = nh.subscribe<rnw_msgs::ConeState>(
          "/rnw/cone_state",
          100,
          &cone_visualizer_t::on_cone_state,
          &cone_viz,
          ros::TransportHints().tcpNoDelay()
  );

  ros::Subscriber sub_rocking_cmd = nh.subscribe<rnw_msgs::RockingCmd>(
          "/rnw/rocking_cmd",
          100,
          &cone_visualizer_t::on_rocking_cmd,
          &cone_viz,
          ros::TransportHints().tcpNoDelay()
  );

  ros::spin();

  ros::shutdown();

  return 0;

}