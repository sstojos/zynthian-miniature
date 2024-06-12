# zynthian-miniature
# Overview
This is repository that store schematics and PCB design for basic PCB with MIDIs, Sound Card and 4 encoders for [zynthian](https://www.zynthian.org). It can also be used for any other raspberry pi audio software. 

![PCB Main](https://github.com/sstojos/zynthian-miniature/blob/main/other-info/PCB-main.png)
![Encoder](https://github.com/sstojos/zynthian-miniature/blob/main/other-info/PCB-encoder.png)

This is designed in KiCad 6.0. It is inspired by clumsy MIDI project.

It comes as a single PCB that need to be split into 5: one main PCB and 4 encoder PCBs.
![5 PCBs](https://github.com/sstojos/zynthian-miniature/blob/main/other-info/pcb.png)

Here is the KiCad schematics screenshot:
![schematics](https://github.com/sstojos/zynthian-miniature/blob/main/other-info/schematics.png)

# BOM
Interactive BOM can be found [here](https://raw.githack.com/sstojos/zynthian-miniature/main/bom/ibom.html).

# Usage scenarious

## JST connectors can be replaced with pinheader connectors
Connectors for encoder wiring are JST 2.5mm connectors but standard 2.54mm pin header connectors can also be used instead.

## PCB mounted MIDI connectors can be replaced with panel mounted MIDI connectors
It can be also used  with MIDI and AUDIO panel connectors. Here is how would you wire external panel connectors.
![external wirring](https://github.com/sstojos/zynthian-miniature/blob/main/other-info/PCB-main-wiring.png)

## It can be used with another sound card 
Sound card must not be installed if another sound card is connected to raspberry pi. I2S sound cards can not share the same rpi pins.
![without sound card](https://github.com/sstojos/zynthian-miniature/blob/main/other-info/PCB-main-without-MIDI-PCB-connectors-and-sound-card.png)

# Zynthian Webconfig

## Sound Card
Audio: HifiBerry DAC+ light

NOTE: can not be used with another audio card that have AUDIO IN (ADC) such as Hifyberry DAC+ ADC or DAC2 PRO ADC because encoder 3 B pin is wired to RPI pin 38 which is often  used by audio cards with ADC for audio in data. In this case there is a need to brake line from encoder 3 B connector to rpi 38 pin on PCB and  patch (solder wire) from encoder 3 b pin to another available rpi pin. Finnaly, wiring configuration in zynthian webconfig need to be changed accordingly. It is an easy patch. 

## Wiring
* Wiring Layout: Dummies
* Advance Configuration: Enabled
* Encoders A-pins: 5,3,28,23
* Encoders B-pins: 4,2,27,22
* Switches pins: 7,25,26,21
