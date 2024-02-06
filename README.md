# Smartphone Controlled Electric Skateboard

Through this project, I have tried to explore IoT technology as well as get more familiar with Arduino and Flutter.

## Arduino Code

The code is made to be uploaded to an Arduino connected to an HC-05 bluetooth module connected to a motor driver. It recieves commands serially and sends signals to the motor driver in accordance to the command recieved.

## Controller Application

For controlling, I have developed an android application using flutter which is able to communicate serially to the microcontroller.

The app consists of one screen and provides the following functionalities:
- Direction buttons: These control with direction the skateboard goes.
- Stop button: Stops the skateboard.
- +/- buttons: Increase and decrease the speed of the skateboard.
- Connect button: Connects with the paired HC-05 module.