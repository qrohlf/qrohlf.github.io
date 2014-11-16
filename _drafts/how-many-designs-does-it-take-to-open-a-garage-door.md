---
title: How Many Designs Does It Take To Open A Garage Door?
summary: A story about iteration
layout: post
date: 2014-11-16
---

# Prelude

I recently moved into a new house, which included an item of particular fascination to me: an electrically-operated garage door opener.  This presented a problem - because there was no exterior switch for either the garage door or the garage lights, the sequence to leave the garage on my bike looked like this:

1. Enter garage via the house door, open garage door (which turns on a light automatically)
2. Move bike outside via the garage door
3. Return to house door, close garage door
4. Exit through front door of house, return to bike in driveway, ride away

Entering the garage with my bike entailed all of the same steps in reverse. As an engineer, I immediately thought of ways to optimize this process. I began carrying a small pocket flashlight and manhandling my bike through the small side door, bypassing the garage door entirely. This eliminated all of the backtracking from the garage-entry-exit procedure:

1. Enter garage via house door using flashlight for illumination
2. Move bike outside via the side door
3. Stow flashlight, ride away

This new method was much faster, but required me to put on my bike gear and push my bike though a narrow doorway one-handed while holding a flashlight; a fairly awkward maneuver. I was convinced that a better solution was out there - and also hungry for a project that would allow me to play with some interesting technology.

# Part One: Square Pegs In Round Holes

> "If all you have is a hammer, everything looks like a nail"
>
> – Maslow's Law of the Instrument

Since I was between side projects, I resolved to build a better garage door opener, one which would solve the problem of opening garage doors for myself and all four of my roommates. As someone who has spent the better part of the last four years as a freelance web developer, my initial reaction was to do this with a web app. Since everyone in our house had iPhones, I reasoned, this would be the most universal solution, and it would also give me the flexibility to do something like build a client that used the phones' locations to auto-open the garage door when we got home. Nifty!

![](/images/how-many-designs/v1-diagram.jpg)

Initially, it all came together fairly nicely. I wrote a client in Node.js that could run on my BeagleBone Black and receive signals from an app running on Heroku via WebSockets. I created a frontend for the Heroku app that looked good on an iPhone and would trigger the garage door opening sequence when a button was pressed. I designed a simple circuit with a transistor and dual 12v/5v power supply that would allow me to trigger our garage door to open with one of the BeagleBone IO pins. After about a week of evening tinkering I had a working proof-of-concept where I could press a button in a webapp on my iPhone and have the house garage door open. Eureka!

![](/images/how-many-designs/v1-electrical.jpg)

Unfortunately, this is where the problems started. The BeagleBone Black had a tendency to kernel panic for no apparent reason every 30 minutes or so - probably due to some experiments I ran with it a year ago that may have caused hardware damage. The WebSocket connection proved unreliable. Furthermore, the process for operating the garage door now looked like this:

1. Pull out iPhone
2. Unlock iPhone
3. Open app, press button to open/close garage door
4. Stow iPhone

This was better than the awkward bike-and-flashlight wrestling that I'd been doing, but still not ideal. I needed to simplify my design and rethink what the ideal UX was for a better garage door opener. 

# Part Two: Opportunity Knocking

Around this time I was also playing with ATTiny85 microcontrollers as part of the development process for an electronics workshop I was planning to teach. I'd been using the Adafruit Trinket as a development board and stumbled across this [tutorial](https://learn.adafruit.com/secret-knock-activated-drawer-lock/overview) for a circuit that would use a specific knock as a password to open a drawer. This immediately clicked with me. Knocking on doors to open them is  the most natural UX for locked doors in existence! What could be more sensible than retooling the circuit from the tutorial to trigger the garage door opener based on a secret knock?

A few days later, this design was born:

![](/images/how-many-designs/v2-breadboard.jpg)

Using an ATTiny85-based Trinket, a piezo element, and a simple transistor to trigger the garage door, I could now open the garage door with a pattern of knocks. (For those wondering why I didn't just use the RF garage door opener in the picture to solve my initial problem, we had 5 people in the house and one opener - we wanted a solution that would work for eveyone without buying 4 more $30 RF openers).

The garage door process now looked like this:

1. Knock to open/close
2. There is no step 2

Just as I was getting ready to transfer the circuit to a permanent board and install it in the garage, I realized a problem. I had initially planned to position the device on the wall surrounding the garage door - you'd have to knock to the side of the door to trigger the opener. This was because my design needed to be plugged into a wall outlet for power. However, while the door itself was made out of thin board, the wall was nearly a foot thick, and full of insulation and drywall! You'd have to break your knuckles knocking hard enough for the sensor to pick it up through all of that. 

It was clear that the device needed to be mounted on the garage door itself. However, running a cable from the wall to the moving garage door wasn't really a viable option. I needed to come up with an alternative way to power the circuit.

# Part Three: Finishing Touches

> "The first 90 percent of the code accounts for the first 90 percent of the development time. The remaining 10 percent of the code accounts for the other 90 percent of the development time."
>
> –Tom Cargill, Bell Labs

Finishing things *well* is tricky. Building a proof-of-concept can be hard, but identifying and accounting for all of the possible ways that your prototype can fail in a finished product is nearly always harder. I had a prototype that could open our garage door based on a series of knocks. Now I needed to design a durable circuit and housing that could be mounted on a garage door that would shudder its way open and closed at least three times a day, every day. I also needed to figure out a cheap and long-lasting way to power the circuit without a direct cable to the wall.

# Epilogue