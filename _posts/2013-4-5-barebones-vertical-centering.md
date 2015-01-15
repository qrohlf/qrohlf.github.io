---
title: Bare Bones Vertical Text Centering with JQuery
layout: post
summary: I had a problem with a responsive column layout where multiples lines of text needed to be vertically centered inside the columns no matter how tall they were. This JQuery snippet fixed it.
---

*Note: Don't use this. Really, don't. This post is here for historical reasons, and to remind me to be nice to junior devs because I was one too once.*

In one of the responsive site designs that I worked on recently, I needed equal-height columns with background colors, dynamic widths and vertically centered text. The equal-height columns part has been covered in depth [elsewhere](https://www.google.com/search?q=equal+height+columns). I used Javascript for my solution, as the client wanted rounded corners - something difficult to fake with the pure CSS tricks out there without resorting to funky and un-semantic markup.

The next challenge was how to vertically center the text within the columns. Because the text was multiline and the divs also included images, I couldn't just set `line-height` to match the container height and have done with it. Using `display: table;` and `display: table-cell;` to get vertical centering broke my layout - it also seemed like an ugly hack. So instead, I wrote up a short solution in JQuery. What it does is it finds how much empty space is left below the last element in the div, then adds half of that space to the top of a specified element within that div, resulting in the div being vertically centered. If the element specified by the text-identifier appears at the top of the div, the entire div contents will appear vertically centered. If the element appears at the end of the div content, the element will appear centered within the empty space at the end of the div.


The code that allows it to do this is fairly trivial, save for the code that determines how much empty space is left at the end of a div. Figuring this out took some digging and a lot of experimentation, as the way that element heights are measured in JQuery does not include margins or padding by default. Here's the code to get the empty space in an element:
{%highlight javascript %}

function emptySpace(element) {
	var lowestBottom = 0; 
	$(element).children().each( function() { 
	var bottom = outerBottomOffset($(this)); 
		if (bottom > lowestBottom) { lowestBottom = bottom; } 
	}); 
	var containerBottom = innerBottomOffset($(element)); 
	var emptyHeight = containerBottom - lowestBottom; 
	return emptyHeight;
}

function outerBottomOffset(element) { 
	return element.offset().top + element.outerHeight(true); 
} 

function innerBottomOffset(element) { 
	return element.offset().top 
		   + element.outerHeight(true) 
		   - parseInt(element.css("padding-bottom")) 
		   - parseInt(element.css("margin-bottom")); 
} 
{%endhighlight %}

Combining that with the basic code for the columns, you get [this](http://jsfiddle.net/bbcH7/2/).

That's it. A simple and responsive way to implement equal-height, vertically centered columns with responsive widths and heights using JQuery. I like it because the markup stays semantic, and you can style your columns the same way you can style any div, with border-radius, background images, etc.
