---
layout: post
current: post
cover:  assets/images/arduino-thermometer-logger-cover.jpg
navigation: True
title: Arduino based network temperature logger
date: 2018-12-07 10:00:00
tags: arduino sensor code 
class: post-template
subclass: 'post data science Arduino programing'
author: martin
---

When Arduino came out with their open-source microcontrollers the world changed forever. We saw countless new communities, maker fairies and ways of manipulating hardware. Arduino, for many, represents a prototyping stepping stone towards finished products. To others, it is the first encounter to software or hardware or both. Basically its cheap enough, you won't break the bank if it catches on fire.

Nowadays innovation no longer lays just in the hands of experienced professionals, but also in younger groups of individuals.

### The first data logger

My brothers started a project using an Arduino nano. They needed a way to monitor a multitude of temperature points and save data to the cloud. Their first concept started sending data in 2014 and I was about to bring new life to it.
This is how they've done it:
The approach was to use Arduino nano with an ethernet shield to send the data over UTP to a wireless AP and later to the server. They wrote a simple program that reads voltages on analogue pins and sends the data to an IP.
While the code worked fine, its only weakness was the wireless connection. Data was actually missing due to the unreliable connection.

### Upgrades

***Step 1: UTP Cable installation***
This one was just for the sake of reliable connection. A single cable was installed from the main switch to the room Arduino is in.

***Step 2: A different data destination***
A single glance to the code revealed how simple the configuration is. I just needed to change the destination IP, compile and download the code and carefully return the Arduino to its original place.


### Hardware

![Hardware trio](assets/images/arduino-proj-temp.png)


The trio on the image is (from left) Arduino nano (Atmega 328P), ETH shield (ENC 28J60) and a custom voltage divider board.

The logic behind the hardware is to measure the resistance of a temperature variable resistor. or Thermistor. I used are 10K 3950 NTC Epoxy Precision thermistors. It has a +- 1% tolerance and is great for having accurate temperature readings. Range:-55 to 105 deg Celsius.

### Getting the temperature data

Measuring thermistor's resistance requires a simple voltage divider. The divider connects a 10K resistor in series to the thermistor. This way, the gauge has a 50% voltage drop on nominal temperature and a wide variation window. Arduino will be able to comfortably read the analogue value using analogue pins. The voltage will vary within the reading values.

Getting a value of 0 on an analogue pin, means, that the voltage drop only exists through the first resistor.
Reading a Value of 0 means, that the thermistor, or rather, the connections of the thermistor are connected together. This can also be a wiring fault. The important part is that voltage coming to the analogue pins satisfies a maximum range of ADC converter. At the same time, we can benefit from protection from wire faults. That way we can conclude faster on the misbehaviour of the circuit.

### Arduino Code

The goal is to send the accurate readings over the network and ensure that the code can run continuously without memory leaks. The destination is hard-coded into the code. This means that the destination device has to exist for data to be logged. Regarding my configuration, there is a dedicated server running just for that purpose.
Sending accurate information can be achieved by sending integers derived from Arduino's analogRead (). This will give us values from 0 to 1023. Values are converted on the server, where computing is available. The code on Arduino is very straightforward: Read data from pins and send the data.


```C
#include <UIPEthernet.h>
#include <SPI.h>

byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
IPAddress ip(10, 0, 19, 244); // Arduino's IP

char serverName[] = "10.0.19.105"; // destination server

int sensor_pins[8] = {
A0, A1, A2, A3, A4, A5, A6, A7};

String temps[8] = {
"fd", "sdf", "sdf", "sdf", "sdf", "sdf", "sdf", "sdf"};

int number_of_pins = 8;
int c;
EthernetClient client;
String data;
void setup() {

Serial.begin(9600);
Ethernet.begin(mac, ip);
Serial.print("ip-");
Serial.println( Ethernet.localIP());
Serial.print("Subnet mask-");
Serial.println( Ethernet.subnetMask());
Serial.print("Gateway-");
Serial.println( Ethernet.gatewayIP());
Serial.print("DNS-");
Serial.println( Ethernet.dnsServerIP());

}

void loop() {
delay(5000);

temps[0] = String(analogRead(sensor_pins[0]));
temps[1] = String(analogRead(sensor_pins[1]));
temps[2] = String(analogRead(sensor_pins[2]));
temps[3] = String(analogRead(sensor_pins[3]));
temps[4] = String(analogRead(sensor_pins[4]));
temps[5] = String(analogRead(sensor_pins[5]));
temps[6] = String(analogRead(sensor_pins[6]));
temps[7] = String(analogRead(sensor_pins[7]));

sendGET(temps);

}

void sendGET(String temps[]) //client function to send/receive GET request data.
{
if (client.connect(serverName, 80)) { //starts client connection, checks for connection
client.write("readings:");
client.write("{");
client.print(temps[0]);
client.write(",");
client.print(temps[1]);
client.write(",");
client.print(temps[2]);
client.write(",");
client.print(temps[3]);
client.write(",");
client.print(temps[4]);
client.write(",");
client.print(temps[5] );
client.write(",");
client.print(temps[6]);
client.write(",");
client.print(temps[7]);
client.write("}");

client.println(""); //download text
client.println("");
client.println(); //end of get request
}
else {
Serial.println("connection failed"); //error message if no client connect
Serial.println();
}

while(client.connected() && !client.available()) delay(5); //waits for data
while (client.connected() || client.available()) { //connected or data available
c = client.read(); //gets byte from ethernet buffer
Serial.print(c); //prints byte to serial monitor
}

Serial.println();
Serial.println("disconnecting.");
Serial.println("==================");
Serial.println();
client.stop(); //stop client
}
```
Update: updates regarding memory leaks: [here](/arduino-data-logger-tweaks.html)

### Server code
Processor time on the destination server allows smooth calculation of values to temperatures.  The code below transforms Arduino's readings (0-1023) into temperature values (-55 to 105degrees).

```python
import numpy as np

numbers = [243,240,286,282,256,350,198] #readings on analog pins

numbers = [float(x) for x in numbers]
# calculate thermistor resistance
# R = 10K*ADC/(1023-ADC)
numbers = [(10000 * i)/(1023 - i) for i in numbers]
# get the ratio between nominal value and current resistance
# R/R0
numbers = [i/10000 for i in numbers]
#calculate log value of the ratio
# log(R/R0)
numbers = [np.log(i) for i in numbers]
# multiply with beta coeficient
# 1/B x log(R/R0)
numbers = [ i/3950 for i in numbers]
# add nominal temperature value
# 1/(T0 + 273) + 1/B x log(R/R0)
numbers = [float(1/float(25 + 273)) + i for i in numbers]
# reciprocal value - converts to F
# 1/val
numbers = [ 1/i for i in numbers]
# convert from F to C
# val - 273
numbers = [int(i - 273) for i in numbers]
numbers
# at the en you should get the temperatures
# [53, 54, 47, 48, 51, 40, 60]
```
As you can notice, the calculation
is divided into several steps for debugging reasons.

If you need some further explanation. You can find details about transforming resistance to voltage here:
[Adafruit thermistor tutorial here](https://learn.adafruit.com/thermistor/using-a-thermistor)

