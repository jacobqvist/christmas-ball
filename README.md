# Christmas ball
Dancing around the christmas tree, unwrapping presents and having a good time together with the family can lead to a lack of time perception. Over time the level of CO2 will accumulate to a level that can cause headache, which is a horrible way to end christmas night. This christmas ball will gently show when the level of CO2 is above a given threshold. I decided to have a threshold of 2000 ppm, but according to [dhs.wisconsin.gov](https://www.dhs.wisconsin.gov/chemical/carbondioxide.htm#:~:text=400%E2%80%931%2C000%20ppm%3A%20typical%20level,stagnant%2C%20stale%2C%20stuffy%20air) a level below 1000 is to be prefered.  

![Spinning christmas tree](media/spin_tree.gif)
## Step by step
### 1. Components
The project uses the following components:
1. ESP32-wroom-32E development board
2. [SCD30 sensor](https://www.sensirion.com/en/environmental-sensors/carbon-dioxide-sensors/carbon-dioxide-sensors-scd30/)
3. NeoPixel Jewel LED module
4. Battery
5. Cables

### 2. Putting everything together

Put everything together as shown in the image. The ESP32 pin connection to the SCD30 sensor is as follows:
- GPIO21 > SDA
- GPIO22 > SCL
- 3.3V > 3V
- GND > GND

NeoPixel Jewel
- GPIO27 > Data input
- GND > GND
- 5V > 5V DC

![Circuit schematic](media/scd30.png)

### 3. Running the program
Prepare the open source Toit language by following the steps [here](https://github.com/toitlang/toit).

Compile an ESP32 image from the program:
```
cd <path-to-toit-lang>
make esp32 ESP32_ENTRY=<path-to-spin-tree>/spin-tree/src/main.toit
```
Connect the ESP32 to your computer and flash the program by pasting the output from `make esp32` into the terminal.

### 4. Enjoy the festivities
Once the program has been flashed, it will start running every time the ESP32 is powered on.

## Useful links
- The stepper motor driver has been compiled into a Toit package: https://github.com/toitware/toit-A3967
- I used this guide to figure out how to wire up the stepper motor with the driver: https://learn.sparkfun.com/tutorials/easy-driver-hook-up-guide
- The EasyDriver webpage provided the step resolution values: http://www.schmalzhaus.com/EasyDriver/
