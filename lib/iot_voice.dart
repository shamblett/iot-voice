/*
 * Package : iot_home_sensors
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 29/09/2017
 * Copyright :  S.Hamblett
 */

library iot_voice;

import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:math';
import 'dart:io';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart' as mqtt;
import 'package:just_jwt/just_jwt.dart' as jwt;
import 'package:path/path.dart' as path;
import 'package:typed_data/typed_data.dart' as typed;
import 'package:mraa/mraa.dart' as mraa;
import 'package:grove/grove.dart' as sensor;

part 'src/sensors/iot_voice_isensor.dart';

part 'src/sensors/iot_voice_platform_sensor.dart';

part 'src/iot_voice_mqtt_bridge.dart';

part 'src/secret/iot_voice_secrets.dart';

