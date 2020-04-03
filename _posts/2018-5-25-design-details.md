---
title: Design Details
layout: post
summary: A technical dive
---

In both my day job at Ride with GPS and in my [ever](https://trianglify.io/)-[expanding](http://logbook.qrohlf.com/) set of [side](https://github.com/qrohlf/GifHub) projects, one of my favorite things is when the broad strokes of a project are in place, and I get to take a little time to obsess over the details.

There are a lot of great detail-oriented resources out there like the [Design Details](https://brianlovin.com/design-details/) blog/podcast, [UX Collective](https://uxdesign.cc/), and some of the [Google Design](https://medium.com/google-design/a-fish-in-your-ear-134deed70268) product deep-dives. Most of these have tons of great animation examples, mockups, and original illustrations that come along with this.

I want to do something a little bit different here, and focus on some of the *code* that powers the design details that I've worked on lately. I feel like there's a big gap between all the wonderfully-written, mockup-heavy content out there on blogs, medium, etc, and all the gee-whiz technical demos put out there on Codepen and similar sites (which tend to look awesome but are rarely code you'd want to use in production). So, here's a small collection of some of the tricky UX details that I've worked on recently, with both UX context and technical explanations.

## Bold fonts, no wiggle

(you might be able to use Trianglify.io instead of Stash Maps for this one)

This one is from a mapping project that's still pre-release. I wanted a way to convey the selected navigation link in the header, without resorting to underlines, background colors, etc. Using a bold font was a natural way to do this in a subtle way, but presented some challenges because of the different character-width that you get when you switch a font to bold:

!! rest of the project goes here


## Slide-in, fade-out

!! talk about different in and out CSS transitions used for the rwgps RSP header


## Everything must :hover

!! comparison of Trianglify.io with and without hover effects


## Cascade-in, cascade-out

!! dive into the cascade-reveal effect used on http://logbook.qrohlf.com
