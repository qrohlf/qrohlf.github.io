---
title: Blinky - A Micro TV Zapper Kit
summary: ????
layout: post
date: 2014-12-26
---

![project difficulty graph](/images/blinky/project_difficulty_graph.jpg)

One of the first projects that I pursued to help teach me the basics of electronics and gizmo-making was a miniature TV-B-Gone. Now, I've put together a kit so that others can do the same. 

However, this kit is a little different from most. One of the things that always bothered me about normal "learn electronics" kits is that they're very on-the-rails experiences that create a high barrier to entry to making your own stuff - it's a big jump from soldering stuff onto a labeled, professionally fabricated PCB to designing your own similarly-professional hardware. I'm attempting to bridge that gap with a "kit" that's made entirely out of off the shelf parts, with no fancy custom-etched PCB or pre-programmed components. The idea is that a beginner could easily put it together and produce a reasonably polished end result, and then use the same tools & techniques from the kit to start designing their own hardware. 

This post will walk you through building  "Blinky", a micro-sized TV-B-Gone clone that will fit inside an Altoids smalls tin and turn off nearly any TV at a range of 15-20 feet.

# Parts & Tools

**To build a Blinky, you will need the following parts:**

![parts](/images/blinky/parts.jpg)

- 1 × ATtiny85 Microcontroller ([link](http://www.mouser.com/Search/ProductDetail.aspx?R=ATTINY85V-10PUvirtualkey55660000virtualkey556-ATTINY85V10PU))
- 1 × 8-Pin Component Socket ([link](http://www.mouser.com/Search/ProductDetail.aspx?R=4808-3000-CPvirtualkey51750000virtualkey517-4808-3000-CP))
- 1 × CR2032 3v Coin Battery ([link](http://www.mouser.com/Search/ProductDetail.aspx?R=CR2032virtualkey65800000virtualkey658-CR2032))
- 1 × Coin Battery Holder ([link](http://www.mouser.com/Search/ProductDetail.aspx?R=122-7520-GRvirtualkey56100000virtualkey122-7520-GR))
- 1 × 8MHz Ceramic Resonator ([link](http://www.mouser.com/Search/ProductDetail.aspx?R=ZTT-8.00MTvirtualkey59070000virtualkey520-ZTT800MT))
- 2 × PN2222 NPN Transistors ([link](http://www.mouser.com/Search/ProductDetail.aspx?R=PN2222ABUvirtualkey51210000virtualkey512-PN2222ABU))
- 1 × 220µF Capacitor ([link](http://www.mouser.com/Search/ProductDetail.aspx?R=ECA-0JM221Ivirtualkey66720000virtualkey667-ECA-0JM221I))
- 1 × Slim Tactile Switch ([link](https://www.adafruit.com/product/1489))
- 2 × 220Ω resistors ([link](#))
- 1 × 47Ω resistor ([link](#))
- 1 × Small Mint Tin Sized Prototype Board ([link](https://www.adafruit.com/products/1214))
- 1 × Altoids Smalls Mint Tin ([link](http://www.amazon.com/Altoids-Peppermint-Sugarfree-Ounce-Count/dp/B00DY5ZNAU/ref=sr_1_6?ie=UTF8&qid=1419638389&sr=8-6&keywords=altoids+smalls))


**You will also need the following tools:**

![tools](/images/blinky/tools.jpg)

***Need second picture with AVR Programmer, AVR Breakout, Breadboard, & Coin Cell Breakout here***

- Soldering Iron (with holder & wet sponge) ([link](https://www.adafruit.com/products/2163), [cheaper option](https://www.sparkfun.com/products/9507))
- Solder ([link](https://www.adafruit.com/products/1886) - you can also use [lead-free](https://www.adafruit.com/products/1930) solder, but it makes it a bit tricker)
- Needle-Nosed Pliers ([link](https://www.adafruit.com/products/1368), [cheaper option](https://www.adafruit.com/products/146))
- Flush Cutters ([link](https://www.adafruit.com/products/152), [cheaper option](https://www.sparkfun.com/products/8794))
- Multimeter ([link](https://www.adafruit.com/products/2034), [cheaper option](https://www.sparkfun.com/products/12966))
- AVR Programmer ([link](https://www.adafruit.com/products/46))
- AVR ISP Breadboard Adapter Kit ([link](https://www.adafruit.com/products/1465))
- Breadboard  ([link](https://www.adafruit.com/products/64))
- Coin Cell Breadboard Breakout ([link](https://www.adafruit.com/products/1871))

**The following items are optional, but helpful:**

![tools-extra](/images/blinky/tools-extra.jpg)

- Wire Strippers ([link](https://www.adafruit.com/products/527))
- Third Hand Tool ([link](https://www.adafruit.com/products/291))
- Vise ([link](http://www.amazon.com/PanaVise-Model-Junior-Miniature-Vise/dp/B000B61D22/ref=sr_1_1?ie=UTF8&qid=1419708516&sr=8-1&keywords=panavise+jr))

# Programming Part 1: Wiring

*If you're using a kit you got from me, your ATtiny is pre-programmed. You can skip straight to the [Building & Testing on a Breadboard](#building-&-testing-on-a-breadboard) section.*

This project works by using a microcontroller to send out a whole bunch of TV "off" signals. However, the microcontroller you just bought is blank - it doesn't have any code or TV "off" signals programmed into it yet. We'll use the AVR programmer along with some open-source code to program the microcontroller to send out TV codes whenever it is reset.

The first step is to set up the circuit for programming. We'll do this using a solderless breadboard. If you've never encountered a breadboard before, now would be a good time to review SparkFun's excellent [solderless breadboard tutorial](https://learn.sparkfun.com/tutorials/how-to-use-a-breadboard). Go ahead, I'll wait. 

The AVR ISP programmer cable has six connections on it. VCC and GND are used to provide power to the chip being programmed. The other 4 are used while programming the chip. We'll need to connect all six in order to set up our programmer. The pinout for these connectors can be found in [Atmel AVR Application Note 042](/images/blinky/atmel-2521-avr-hardware-design-considerations_applicationnote_avr042.pdf), and I've included it below. The Adafruit breakout we're using also happens to have each pin labeled, which is nice.

![AVR ISP 6-Pin Pinout](/images/blinky/isp_pinout_6pin.jpg)
<span class="caption">ISP 6-pin connector pinout</span>

First, put the AVR programming adapter on the breadboard and connect the VCC and GND to the power rails of your breadboard. I like to keep my wiring as flush with the breadboard as possible - it helps with organization. Note the power jumpers at the bottom of the board - I often forget these and then get really confused when my circuit doesn't work because one power rail isn't connected to anything.

![Power Rails Connected](/images/blinky/programmer_power.jpg)
<span class="caption">ISP power connections</span>

Next, we'll add the ATtiny85 chip. The pinout for this chip can be found in its [datasheet](/images/blinky/atmel-2586-avr-8-bit-microcontroller-attiny25-attiny45-attiny85_datasheet.pdf). On the physical chip, the top left of the chip will be marked with a small dot. If you plug the chip in backwards, it **will fry the chip**, so be careful and pay attention to the dot!

![Attiny85 Pinout](/images/blinky/attiny85_pinout.png)
<span class="caption">ATtiny85 pinout</span>

To get the chip to fit in the breadboard, you'll need to bend the leads a little bit. Use a table or other flat surface to gently bend the leads inward on each side:

![Gently bend the ATtiny leads](/images/blinky/bending_leads.jpg)
<span class="caption">Gently bend the ATtiny leads</span>

Plug the chip into the breadboard, paying careful attention to its polarity (the dot in the top left corner), and connect it to the power rails:

![Chip with power](/images/blinky/chip_with_power.jpg)
<span class="caption">Chip with power connections</span>

Next, connect the MISO, MOSI, SCK, and RESET signals to their respective pins on the chip:

![Chip with programmer signals](/images/blinky/chip_with_programmer_signals.jpg)
<span class="caption">Chip with programmer signals</span>

Finally, add the external resonator. This part is used to keep the chip's timing accurate, and we'll need it connected during programming. The resonator has three leads - the outer two need to be connected to the chip's XTAL1 and XTAL2 pins and the inner lead needs to be connected to ground. The orientation of the resonator doesn't matter. With a little bit of sneaky placement, you can accomplish this with a single jumper wire:

![Resonator](/images/blinky/resonator.jpg)
<span class="caption">The resonator looks like this</span>

![Chip with resonator](/images/blinky/chip_with_resonator.jpg)
<span class="caption">Resonator in place</span>

Finally, plug the programmer into the breadboard. Make sure that the red wire is at the top (this shows the polarity of the programming cable).

![Ready to program](/images/blinky/ready_to_program.jpg)
<span class="caption">Ready to program</span>

# Programming Part 2: Software

Now that your chip is all wired up and ready to program, it's time to get the programming environment setup on your computer. This will allow your computer to download instructions to the chip via the programmer. 

The first thing you'll need to do is install avrdude, an open-source utility for programming AVR chips. On OSX, I do this by installing [homebrew](http://brew.sh/#install), then running `brew install avrdude` in the terminal. Most Linux distributions also have avrdude available from their package managers. For Windows, you can follow [this tutorial](http://www.ladyada.net/learn/avr/setup-win.html) to install WinAVR which includes avrdude.

Once you've got avrdude installed, you should be able to run `avrdude` in your terminal and get a list of all the options that avrdude supports. If you get a "command not found" message instead, go back and troubleshoot/reinstall avrdude.

The next thing you'll need is version 1.1b of the TV-B-Gone microcontroller software. Download it [here](/images/blinky/tvbgone11b.zip). (I got it from Adafruit's [site](https://learn.adafruit.com/tv-b-gone-kit/download)). 

Unzip the tvbgone11b.zip file you just downloaded somewhere convenient. Inside the directory there are a bunch of files, but the one we care about is tvbgone.hex. This is the compiled version of software, ready to be downloaded to the chip using AVRdude.

Now we'll be actually programming the board. Make sure that your programmer is plugged into your computer and that your breadboard is plugged into your programmer in the correct orientation with the red wire at the top. Then run this command in your terminal:

```
avrdude -c usbtiny -p attiny85 -U lfuse:w:0xfe:m -U hfuse:w:0xdf:m -U efuse:w:0xff:m
```

This sets the chip to use the external oscillator for timing. You should see a line of output that looks like this:

```
avrdude: safemode: Fuses OK (E:FF, H:DF, L:FE)
```

Next, flash the tvbgone.hex file by running this command (make sure to change `/Users/qrohlf/Downloads/` to wherever you extracted the folder to):

```
avrdude -B 1 -c usbtiny -p attiny85 -U flash:w:/Users/qrohlf/Downloads/tvbgone11b/tvbgone.hex
```

You should see some progress bars and finally some lines of output that look like this:

```
avrdude: verifying ...
avrdude: 8188 bytes of flash verified
```

If you see that, you've successfully programmed your ATtiny85 with the TV-B-Gone software and you're ready to start building the TV-B-Gone circuit!

# Building & Testing on a Breadboard

Once you've gotten all of your parts 

# Final Assembly

Lots of pictures