#include "rnw_ros/traj_uitls.h"
#include "rnw_ros/pose_utils.h"

#include "quadrotor_msgs/PositionCommand.h"

ros::Publisher pub_path_setpoint;
ros::Publisher pub_path_plant;
ros::Publisher pub_pos_cmd;

PolynomialTraj minsnap( vector<Vector3d> const & waypoints, double interval ){
  MatrixXd POS = toXd(waypoints);
  VectorXd TIMES = gen_time_intervals(interval,waypoints);
  return minSnapTraj(POS,Vector3d::Zero(),Vector3d::Zero(),Vector3d::Zero(),Vector3d::Zero(),TIMES);
}

PoseStamped eigen2pathpoint( Vector3d const & T ){
  geometry_msgs::PoseStamped pose;
  pose.header.stamp = ros::Time::now();
  pose.pose.position = eigen2ros(T);
  return pose;
}

struct traj_server_t {

    nav_msgs::Odometry base_odom; // trajectory is defined in this reference frame, FLU

    Vector3d base_T;

    double base_yaw;

    PolynomialTraj traj;

    bool traj_available = false;

    void init( OdometryConstPtr const & msg ){

      base_odom = *msg;

      ROS_INFO_STREAM(base_odom);

      Matrix3d R = odom2R(msg);
      Vector3d T = odom2T(msg);

      base_yaw = quat2eulers(Quaterniond(R)).z();
      base_T = T;
      base_T.x() += 0.25;

      vector<Vector3d> waypoints = gen_waypoint_zigzag(5,0.25,0.5);

      vector<Vector3d> wps = transform_pts(waypoints,R,T);

      traj = minsnap(wps,1);

      traj_available = true;

    }

    ros::Time traj_start_time;

    bool traj_started = false;

    double dt() {
      if (!traj_started) {
        traj_start_time = ros::Time::now();
        traj_started = true;
      }
      return (ros::Time::now() - traj_start_time).toSec();
    }

};

traj_server_t traj_server;

void on_odom( OdometryConstPtr const & odom ) {

  static nav_msgs::Path path_setpoint;
  static nav_msgs::Path path_plant;
  path_setpoint.header.frame_id = "world";
  path_plant.header.frame_id = "world";

  if ( !traj_server.traj_available ) {
    traj_server.init(odom);
  }
  else {

    quadrotor_msgs::PositionCommand cmd;
    cmd.position = eigen2ros(traj_server.base_T);
    cmd.velocity = eigen2rosv(Vector3d::Zero());
    cmd.acceleration = eigen2rosv(Vector3d::Zero());
    cmd.yaw = traj_server.base_yaw;
    cmd.yaw_dot = 0;

    pub_pos_cmd.publish(cmd);

  }

}

int main( int argc, char** argv ) {

  ros::init(argc,argv,"traj_server_node");

  ros::NodeHandle nh("~");

  pub_path_setpoint = nh.advertise<nav_msgs::Path>("/traj/setpoint",10);
  pub_path_plant = nh.advertise<nav_msgs::Path>("/traj/plant",10);
  pub_pos_cmd = nh.advertise<quadrotor_msgs::PositionCommand>("/position_cmd",10);

  ros::Subscriber sub_odom = nh.subscribe<nav_msgs::Odometry>("vicon",10,on_odom);

  ros::spin();

  ros::shutdown();

  return 0;

}