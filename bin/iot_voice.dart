/*
 * Project : iot-voice
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 05/07/2021
 * Copyright :  S.Hamblett
 */

import 'dart:io';
import 'dart:async';
import 'package:iot_voice/iot_voice.dart';
import 'package:args/args.dart';
import 'package:intl/intl.dart';

Future main(List<String> args) async {
  var mqttLogging = false;
  var sampleRate = IotVoiceISensor.defaultSampleTime;

  /// Command line parameters
  final parser = ArgParser();
  parser.addFlag('log',
      abbr: 'l', defaultsTo: false, callback: (log) => mqttLogging = log);
  parser.addOption('sampleRate',
      abbr: 's', defaultsTo: IotVoiceISensor.defaultSampleTime.toString(),
      callback: (sampleRateOption) {
    sampleRate = int.parse(sampleRateOption!);
    if (sampleRate <= 0) {
      sampleRate = IotVoiceISensor.defaultSampleTime;
    }
  });

  parser.parse(args);

  /// Announce and start
  print(
      'Welcome to iot-voice for device ${IotVoiceSecrets.dummyDeviceId} with a sample rate of $sampleRate seconds');

  /// Create our sensor and start it
  final sensor = IotVoicePlatformSensor(sampleRate);
  sensor.initialise();
  sensor.start();

  /// Create our MQTT bridge and initialise it
  final bridge = IotVoiceMqttBridge(IotVoiceSecrets.dummyDeviceId);
  bridge.logging = mqttLogging;
  bridge.initialise();

  // Listen for any input on stdin, if any stop the sensor
  stdin.listen((List<int> data) => sensor.stop());

  /// Listen for values
  final format = DateFormat('y-MM-dd-HH:mm:ss');
  await for (IotVoiceSensorData data in sensor.values) {
    final dateString =
        format.format(DateTime.fromMillisecondsSinceEpoch(data.at));
    print('Platform sensor value is ${data.value} at time $dateString');
    // Dont publish unless the bridge is ready
    if (bridge.initialised) {
      bridge.update(data);
    } else {
      print('iot-voice: not updated bridge not ready');
    }
  }

  print('Goodbye from iot-voice');
  exit(0);
}
