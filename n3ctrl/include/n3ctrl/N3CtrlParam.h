#ifndef	__N3CTRLPARAM_H
#define __N3CTRLPARAM_H

#include <ros/ros.h>

#include <n3ctrl/GainsConfig.h>

enum class ctrl_strategy_e {
    tianbo = 0,
    mellinger = 1
};

class Parameter_t
{
public:
	struct Gain
	{
		double Kp0,Kp1,Kp2;
		double Kv0,Kv1,Kv2;
		double Kvi0,Kvi1,Kvi2;
		double Ka0,Ka1,Ka2;
		double Kap0,Kap1,Kap2;
		double Kyaw;
	};

	struct Idling
	{
		double desired_height_limit;
		double desired_velo_limit;
		double feedback_velo_limit;
		double js_thrust_limit;
		double landing_timeout;
		double landing_thrust_percent;
		double lowest_thrust;
	};

	struct RC
	{
		double hori_velo_scale;
		double vert_velo_scale;
		double yaw_scale;
		double attitude_scale;
		
		double deadzone;
		double exit_cmd_deadzone;
	};

	struct Hover
	{
		bool set_hov_percent_to_zero;
		bool use_hov_percent_kf;

		double vert_velo_limit_for_update;
		double vert_height_limit_for_update;
		
		double percent_lower_limit;
		double percent_higher_limit;
	};

	struct MsgTimeout
	{
		double odom;
		double rc;
		double cmd;
	};

	Gain hover_gain, track_gain;
	Idling idling;
	RC rc;
	Hover hover;
	MsgTimeout msg_timeout;

	double mass;
	double gra;
	double hov_percent;
	double full_thrust;

	double ctrl_rate;
	
	double js_ctrl_lock_velo;

	std::string work_mode;
	std::string js_ctrl_mode;

	bool use_yaw_rate_ctrl;

	bool pub_debug_msgs;

	Parameter_t();
	void config_from_ros_handle(const ros::NodeHandle& nh);
	void init();
	void config_full_thrust(double hov);
private:	
	template<typename TName, typename TVal>
	void read_essential_param(const ros::NodeHandle& nh, const TName& name, TVal& val)
	{
		if (nh.getParam(name, val))
		{
			// pass
		}
		else
		{
			ROS_ERROR_STREAM("Read param: " << name << " failed.");
			ROS_BREAK();
		}
	};


public:

    // XU Pu

    bool enable_dynamic_reconfigure;

    int ctrl_strategy;

    /**
     * @return default values for dynamic_reconfigure
     */
    n3ctrl::GainsConfig get_defaults() const;

};

inline std::ostream & operator << ( std::ostream &out, const Parameter_t::Gain & gains )
{
  out << "Kp(" << gains.Kp0 << ", " << gains.Kp1 << ", " << gains.Kp2 << "), ";
  out << "Kv(" << gains.Kv0 << ", " << gains.Kv1 << ", " << gains.Kv2 << "), ";
  out << "Kvi(" << gains.Kvi0 << ", " << gains.Kvi1 << ", " << gains.Kvi2 << "), ";
  out << "Ka(" << gains.Ka0 << ", " << gains.Ka1 << ", " << gains.Ka2 << "), ";
  out << "Kyaw(" << gains.Kyaw << ")";
  return out;
}

#endif