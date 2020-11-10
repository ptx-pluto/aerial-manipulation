package djiros;

public interface MFIOConfig$Service extends org.ros.internal.message.Message {
  static final java.lang.String _TYPE = "djiros/MFIOConfig$Service";
  static final java.lang.String _DEFINITION = "#constant for mode\nuint8 MODE_PWM_OUT  = 0\n#uint8 MODE_PWM_IN  = 1 #PWM_IN is not functioning correctly\nuint8 MODE_GPIO_OUT = 2\nuint8 MODE_GPIO_IN  = 3\nuint8 MODE_ADC      = 4\n\n#request\nuint8 mode              # see constants above for possible modes\nuint8 channel           # 0-7\nuint32 init_on_time_us  # on time for pwm duty cycle in micro-seconds\nuint16 pwm_freq         # set pwm frequency in Hz\n---\n";
  static final boolean _IS_SERVICE = true;
  static final boolean _IS_ACTION = false;
}
