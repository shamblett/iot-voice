# GPIO Example - how to run and what to expect

The dart program iot_voice_gpio.dart and its associated configuration file demonstrate simple control of the Raspberry PI
GPIO pins from Dart using the mraa package.

The program prints out the mraa library version in use, the platform details then flashes a LED for 10 seconds after which
there is a 20-second period where if a switch is operated the LED will turn on. The program prints output to the screen to
inform the user of what to do/expect.

The GPIO pins used by the program are specified in the config file with the ledGPIOPin and switch GPIOPin
constants. These can be any supplied GPIO pins.

The mapping of mraa pin number to the Raspberry PI GPIO pin is platform specific, my board is a
Raspberry Pi 4 Model B and has the following mraa to GPIO pin mapping :-
```
01         3V3:
02          5V:
03        SDA0: GPIO I2C  
04          5V:
05        SCL0: GPIO I2C  
06         GND:
07       GPIO4: GPIO
08     UART_TX: GPIO UART
09         GND:
10     UART_RX: GPIO UART
11      GPIO17: GPIO
12      GPIO18: GPIO PWM  
13      GPIO27: GPIO
14         GND:
15      GPIO22: GPIO
16      GPIO23: GPIO
17         3V3:
18      GPIO24: GPIO
19    SPI_MOSI: GPIO SPI  
20         GND:
21    SPI_MISO: GPIO SPI  
22      GPIO25: GPIO
23     SPI_CLK: GPIO SPI  
24     SPI_CS0: GPIO SPI  
25         GND:
26     SPI_CS1: GPIO SPI  
27       ID_SD:
28       ID_SC:
29      GPIO05: GPIO
30         GND:
31      GPIO06: GPIO
32      GPIO12: GPIO
33      GPIO13: GPIO
34         GND:
35      GPIO19: GPIO
36      GPIO16: GPIO
37      GPIO26: GPIO
38      GPIO20: GPIO
39         GND:
40      GPIO21: GPIO 
```

Other boards may vary, please use the 'mraa-gpio list' command to see the mapping for your board.

Note that the program comes with its own copy of the mraa library(selectable via the config file). This is because the Raspberry Pi 4 Model B is a relatively new board, support for this has been incorporated into 
the mraa library but not yet released to the distro's. Contrast the output of the distro supplied 'mraa-gpio list' command and the one supplied locally if you are
using a Raspberry Pi 4 Model B.

To run the program from the iot-voice project directory type -

```dart bin/iot_voice_gpio.dart```

Note also that depending on your board config you may have to run this with elevated privileges, if so
type -

```sudo dart bin/iot_voice_gpio.dart```