/*
 * Package : iot_voice
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 17/08/2021
 * Copyright :  S.Hamblett
 */

import 'dart:io';
import 'package:mraa/mraa.dart';
import 'package:path/path.dart' as path;
import 'iot_voice_gpio_config.dart';

/// Simple GPIO example on the Raspberry pi for IOT Voice.
int main() {
  var mraa;
  // Check for local or distro mraa library
  if (useDistro) {
    print('Using distro supplied version of mraa library');
    mraa = Mraa()
      ..noJsonLoading = noJsonLoading
      ..useGrovePi = useGrovePi
      ..initialise();
  } else {
    print('Using local supplied version of mraa library');
    final mraaPath = path.join(path.current, 'bin', 'mraa', mraaLibraryPath);
    mraa = Mraa.fromLib(mraaPath)
      ..noJsonLoading = noJsonLoading
      ..useGrovePi = useGrovePi
      ..initialise();
  }

  // Version
  final mraaVersion = mraa.common.version();
  print('Mraa version is : $mraaVersion');

  print('Initialising MRAA');
  final ret = mraa.common.initialise();
  if (ret != MraaReturnCode.success) {
    print('Failed to initialise MRAA, return code is '
        '${returnCode.asString(ret)}');
  }

  print('Getting platform name');
  final platformName = mraa.common.platformName();
  print('The platform name is : $platformName');

  /// The LED initialisation
  print('Initialising LED');
  final ledContext = mraa.gpio.initialise(ledGPIOPin);
  mraa.gpio
      .direction(ledContext, MraaGpioDirection.out); // LED is an 'out' device

  /// The switch initialisation
  print('Initialising switch');
  final switchContext = mraa.gpio.initialise(switchGPIOPin);
  mraa.gpio.direction(
      switchContext, MraaGpioDirection.inn); // Switch is an 'in' device

  print('Flash the LED for 10 seconds');
  // Note that on my board 0 turns the LED on, 1 Off
  for (var i = 0; i <= 9; i++) {
    mraa.gpio.write(ledContext, 0);
    print('LED on');
    sleep(const Duration(milliseconds: 500));
    mraa.gpio.write(ledContext, 1);
    print('LED off');
    sleep(const Duration(milliseconds: 500));
  }

  print('Pressing the switch will now light the LED, you have 20 seconds');
  var stop = 0;
  while (stop < 400) {
    var switchValue = mraa.gpio.read(switchContext);
    if (switchValue == 1) {
      mraa.gpio.write(ledContext, 0);
    } else {
      mraa.gpio.write(ledContext, 1);
    }
    sleep(const Duration(milliseconds: 50));
    stop++;
  }

  print('GPIO test complete');
  return 0;
}
