/*
 * Package : iot_voice_sensors
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 05/07/2021
 * Copyright :  S.Hamblett
 */

part of iot_voice;

/// The platform sensor class, this class generates a JSON formatted text string
/// representing the state of the devices on the platform.
class IotVoicePlatformSensor extends IotVoiceISensor {
  /// Construction
  IotVoicePlatformSensor([sampleTime = IotVoiceISensor.defaultSampleTime]) {
    type = SensorTypes.platform;
    status = '';
    state = SensorState.stopped;
    this.sampleTime = sampleTime;
    statusData = File(IotVoiceSecrets.statusFilePath);
  }

  /// The status data json file
  late File statusData;

  /// The value generation period timer and its callback
  late Timer _timer;

  void _timerCallBack(Timer timer) {
    final data = getSensorData();
    _values.add(data);
  }

  /// Initialiser
  @override
  void initialise() {
    /// Nothing to do here
  }

  /// Start sensing
  @override
  void start() {
    /// Start the periodic timer
    _timer = Timer.periodic(Duration(seconds: sampleTime), _timerCallBack);

    /// Generate an initial value
    final data = getSensorData();
    _values.add(data);
    state = SensorState.started;
  }

  /// Stop sensing
  @override
  void stop() {
    _timer.cancel();
    state = SensorState.stopped;
    _values.close();
  }

  @override
  IotVoiceSensorData getSensorData() {
    final message = IotVoiceSensorData();
    message.status = statusData.readAsStringSync();
    message.at = at.millisecondsSinceEpoch;
    message.type = type;
    return message;
  }
}
