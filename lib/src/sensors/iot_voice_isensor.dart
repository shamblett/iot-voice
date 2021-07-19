/*
 * Package : iot_voice
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 05/07/2021
 * Copyright :  S.Hamblett
 */

part of iot_voice;

/// Sensor types
enum SensorTypes { none, platform }

/// Sensor state
enum SensorState { none, started, stopped }

/// Sensor data packet
class IotVoiceSensorData {
  SensorTypes? type = SensorTypes.none;
  String status = '';
  int at = 0;

  /// toString, remove the enum type from SensorTypes
  @override
  String toString() {
    return '${at.toString()}:$status';
  }
}

/// Interface for all the sensors
abstract class IotVoiceISensor {
  static const int defaultSampleTime = 10; // seconds

  /// The type of the sensor
  SensorTypes type = SensorTypes.none;

  /// The state the sensor is in
  SensorState state = SensorState.none;

  /// The status of the sensor
  String status = '';

  /// The time the value was set(acquired)
  late DateTime at = DateTime.now();

  /// Time between sensor samples in seconds.
  late int sampleTime;

  /// The stream of values emitted by the sensor
  final StreamController<IotVoiceSensorData> _values =
      StreamController<IotVoiceSensorData>.broadcast();

  Stream<IotVoiceSensorData> get values => _values.stream;

  /// Initialiser
  void initialise();

  /// Start sensing
  void start();

  /// Stop sensing
  void stop();

  /// Get the latest sensor data as a message
  IotVoiceSensorData getSensorData();
}
