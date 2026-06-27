# I2S Audio Engine

This repo provides a digital system designed to process serial data and generate audio signals. The UART receiver and decoder modules handle incoming ASCII characters, which are subsequently mapped to specific musical keys. A melody generator and specialized package file collaborate to produce digital audio samples based on these inputs. These samples are then formatted for output via an I2S transmitter, which manages the timing clocks and serial data stream required for audio hardware. Finally, the repo includes testbenches for i2s-transmitter and UART-reciever to verify the functionality of these two protocol.  
  
---

## 1. Project Overview

The primary goal of this project is to create an interactive musical system. When you send **ASCII characters** (standard text) through a serial connection, the system identifies the character and maps it to a specific musical note. These notes are then synthesized into digital audio samples and transmitted using the **I2S protocol**. This project covers the full path of data: from receiving raw serial bits to producing high-quality 24-bit audio signals.  
  
![Block Diagram](https://nazaninazhdari.github.io/i2s-audio-engine/doc/diagram/Block_Diagram.PNG)  

  
---

## 2. Module Descriptions

### **UART_RX (Universal Asynchronous Receiver)**
This is the entry point of the system. It receives 8 bits of serial data, one start bit, and one stop bit. It uses a generic called `g_CLKS_PER_BIT` to match the FPGA’s internal clock (50MHz) to the desired baud rate (e.g., 115200). Once a complete character is received, it triggers a "Data Valid" signal (`o_data_DV`) to let the rest of the system know a new character is ready.  
  
![UART FSM](https://nazaninazhdari.github.io/i2s-audio-engine/doc/diagram/UART_FSM.PNG)  

### **RX_decoder**
This module acts as a translator. It takes the 8-bit ASCII code from the UART receiver and maps it to 26 different output ports (`o_key_a` through `o_key_z`). This allows the system to recognize which letter was typed and trigger the corresponding musical response.

### **melody_pack**
This is my custom package that provides a specialized data type called `t_tone_array`. This array allows the system to store a flexible list of tone frequencies, making it easier to manage the "library" of sounds the engine can produce.

### **melody_gen (Melody Generator)**
This is the heart of the sound production. It generates audio samples (24-bit resolution) by toggling between positive and negative amplitudes (`AMP_POS` and `AMP_NEG`) to create a digital wave. It uses the `LRCLK` (Left-Right Clock) as a reference to ensure the notes are played at the correct frequency and for the correct duration.

### **i2s_tx (I2S Transmitter)**
To hear the sound, the digital samples must be sent to an audio codec. This module generates three critical clocks:
*   **MCLK (Master Clock):** 12.5 MHz for the hardware's internal timing.
*   **BCLK (Bit Clock):** 3.125 MHz to time each individual bit of data.
*   **LRCLK (Left-Right Clock):** 48.828 kHz, which determines the audio sample rate.
It serializes the 32-bit samples into a continuous stream of data for the audio hardware.  

![I2S slide1](https://nazaninazhdari.github.io/i2s-audio-engine/doc/diagram/I2S_Slide1.PNG)  
---
![I2S slide2](https://nazaninazhdari.github.io/i2s-audio-engine/doc/diagram/I2S_Slide2.PNG)  

### **audio_engine_top**
This is the top-level entity that connects all the modules mentioned above. It handles the 50MHz system clock, the reset logic, and routes the signals between the UART, the decoder, the generator, and the transmitter.

---

## 3. Setup Guide

### **Verification:** 
You can use the provided testbenches (`UART_RX_TB` and `i2s_tx_TB`) in your desired simulator(I have used Isim to write and simulate them) before loading the design onto the hardware to verify that the timing and data streams are correct.
### **Serial Settings:** 
Configure your PC's serial terminal (I used PuTTY) to match the `g_CLKS_PER_BIT` setting in the `UART_RX` module (typically 115200 baud).  
![com configuration](https://nazaninazhdari.github.io/i2s-audio-engine/doc/diagram/COM_configuration.png)
### **Hardware Deployment:** 
This audio engine has been tested on the Cyclone V GX FPGA, to see the pinout table click on link below:  
[Click here to open the Pinout-Table.CSV](https://nazaninazhdari.github.io/i2s-audio-engine/doc/pinout/i2s_audio_engine_pinout.csv)  
