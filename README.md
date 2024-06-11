# zynthian-miniature
# Overview
This is repository that store schematicsw and PCB design for  basic PCB with MIDIs, Sound Card and 4 encoders for [zynthian](https://www.zynthian.org). 

![PCB Main](https://github.com/sstojos/zynthian-miniature/blob/main/other-info/PCB-main.png)
![Encoder](https://github.com/sstojos/zynthian-miniature/blob/main/other-info/PCB-encoder.png)

This is designed in KiCad 6.0.

It comes as a single PCB that need to be split into 5: one main PCB and 4 encoder OPCBs.
![5 PCBs](https://github.com/sstojos/zynthian-miniature/blob/main/other-info/pcb.png)

Here is assemled PCB:
![assembled](https://github.com/sstojos/zynthian-miniature/blob/main/other-info/assembled.png)

# BOM
Interactive BOM can be found [here](https://raw.githack.com/sstojos/zynthian-miniature/main/bom/ibom.html).

# Usage scenarious

## JST connectors can be replaced with [pinheader connectors
Connectors for encoder wirring are are JST 2.5mm connectors but standard 2.54 pin header connectors can be used instead.

## PCB mounted MIDI connectors can be replaced with panel mounted MIDI connectors
It can be also used  with MIDI and AUDIO panel connectors. Here is how would you wire external panel connectors.
![external wirring](https://github.com/sstojos/zynthian-miniature/blob/main/other-info/PCB-main-wiring.png)

## It can be used with another sound card 
Sound card must not be installed if another sound card is connected to raspberry pi. I2S sound cards can not share the pins.
![without sound card](https://github.com/sstojos/zynthian-miniature/blob/main/other-info/PCB-main-without-MIDI-PCB-connectors-and-sound-card.png)

# Zynthian Webconfig

## Sound Card
Audio: HifiBerry DAC+ light

## Wiring
* Wiring Layout: Dummies
* Advance Configuration: Enabled
* Encoders A-pins: 5,3,28,23
* Encoders B-pins: 4,2,27,22
* Switches pins: 7,25,26,21
