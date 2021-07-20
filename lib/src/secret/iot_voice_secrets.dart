/*
 * Package : iot_voice_sensors
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 05/07/2021
 * Copyright :  S.Hamblett
 */

part of iot_voice;

/// Project/ Device Id's etc
class IotVoiceSecrets {
  static const String projectId = 'iot-voice-319013';
  static const String region = 'us-central1';
  static const String registry = 'iot-voice';

  static const String platformDeviceId = 'platform-status';
  static const String statusFilePath =
      '/home/stevehamblett/Development/google/dart/projects/iot-voice/platform/status.json';
}
