package quadrotor_msgs;

public interface OptimalTimeAllocator extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "quadrotor_msgs/OptimalTimeAllocator";
  static final java.lang.String _DEFINITION = "Header header\n\ntime start_time\ntime final_time\n\n# the trajectory id, starts from \"1\".\nuint32 trajectory_id\n\n# the action command for trajectory server.\nuint32 ACTION_ADD                  =   1\nuint32 ACTION_ABORT                =   2\nuint32 ACTION_WARN_START           =   3\nuint32 ACTION_WARN_FINAL           =   4\nuint32 ACTION_WARN_IMPOSSIBLE      =   5\nuint32 action\n\n# the vector of all \'K\' number of each piece of the time profile.\nint32[] K\nint32   K_max\n\n# the a, b, c, d parameters of the TOPP time profile.\nfloat64[] a\nfloat64[] b\n\n# useful variables for evaluating time\nfloat64[] s\nfloat64[] time\nfloat64[] time_acc\n\n# delta_s in s domain\nfloat64   s_step\n\nstring debug_info";
  static final boolean _IS_SERVICE = false;
  static final boolean _IS_ACTION = false;
  static final int ACTION_ADD = 1;
  static final int ACTION_ABORT = 2;
  static final int ACTION_WARN_START = 3;
  static final int ACTION_WARN_FINAL = 4;
  static final int ACTION_WARN_IMPOSSIBLE = 5;
  std_msgs.Header getHeader();
  void setHeader(std_msgs.Header value);
  org.ros.message.Time getStartTime();
  void setStartTime(org.ros.message.Time value);
  org.ros.message.Time getFinalTime();
  void setFinalTime(org.ros.message.Time value);
  int getTrajectoryId();
  void setTrajectoryId(int value);
  int getAction();
  void setAction(int value);
  int[] getK();
  void setK(int[] value);
  int getKMax();
  void setKMax(int value);
  double[] getA();
  void setA(double[] value);
  double[] getB();
  void setB(double[] value);
  double[] getS();
  void setS(double[] value);
  double[] getTime();
  void setTime(double[] value);
  double[] getTimeAcc();
  void setTimeAcc(double[] value);
  double getSStep();
  void setSStep(double value);
  java.lang.String getDebugInfo();
  void setDebugInfo(java.lang.String value);
}
