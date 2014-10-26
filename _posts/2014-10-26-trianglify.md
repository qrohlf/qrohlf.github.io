---
title: Trianglify
summary: Thoughts on my first popular project, and why it matters.
layout: post
date: 2014-10-26 11:24

---

Last spring, I wrote my first JavaScript library. In fact, this was probably the first time I'd written anything in JS longer than 30 lines of code, and definitely the first time I'd done it without JQuery. It was called [Trianglify](http://qrohlf.com/trianglify), and it generated geometric patterns that looked like this:

![example](/images/trianglify/trianglify.png)

It was a small project, and I wrote the initial version in its entirety over the course of a single Thursday. Within two days, it was the most popular piece of code I'd ever written.

While seeing my project go from "one-off-experiment" to trending on GitHub, Hacker News, Twitter, and Reddit was fun, the most exciting thing for me was what happened after the initial surge of traffic wore off. People stopped playing with the demo and they starting *using* it. There was a [version](http://nixterrimus.github.io/Triangle-Play-App/) that expanded on my simple demo with more sliders and color control, a [remix](http://alssndro.github.io/trianglify-background-generator/) that pulled in new color palettes from colourlovers, even a [fork](http://asifmallik.github.io) that used images to get the color mappings. I'd graduated from 'package creator' to 'package maintainer'.

For most people, that's probably not a very exciting transition. If building out new ideas in code is like a sprint, maintaining them is like an marathon with no spectators that never ends. My experience in software development to this point had been as an intern, student, and freelancer - I've never maintained a codebase for more than a few weeks at a time. Now I was doing it in an unfamiliar language, on a project with 3,000+ stars on GitHub.

There's a whole set of skills that are orthogonal to academic coding, but incredibly useful in software development. My users wanted to use Trianglify in Node.js; so I learned about npm, semver, tagging releases in git, and how to write code that would run both on the server and in the browser. I dealt with pull requests and learned how to give good feedback on code contributions. I had to make decisions about browser compatiblity vs. new features. Right now, I'm exploring how to do unit testing properly in Javascript. Overall, I'm certain that I learned more from simply maintaining Trianglify than I did from writing it in the first place.

That's the takeaway here. Maintaining the things that you build is an exercise that can broaden your skill set as a software developer dramatically. That lesson has found its way into my approach to picking side projects, the advice I give to my peers, and the cirriculum for the [class](http://webdev.qrohlf.com) I teach.