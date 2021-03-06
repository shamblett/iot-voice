/*
* Package : iot_voice
* Author : S. Hamblett <steve.hamblett@linux.com>
* Date   : 17/08/2021
* Copyright :  S.Hamblett
*/

/// Configuration for the IOT Voice GPIO example. Update these as needed.

// Use the platform(distro supplied) or local version of MRAA
const useDistro = false;

// Mraa library if using local version
const mraaLibrary = 'libmraa.so.2.2.0';

// Mraa configuration.
const noJsonLoading = true;
const useGrovePi = false;

// The GPIO pin for the Grove LED
const int ledGPIOPin = 29; // Raspberry PI GPIO pin GPIO5

// The GPIO pin for the Grove momentary switch
const int switchGPIOPin = 36; //Raspberry PI GPIO pin GPIO16
