---
title: A Better @font-face Kit for Open Sans
layout: post
summary: The @font-face kits I've seen for Open Sans all suck. So I built a better one.
---

*Disclaimer:
This post is intended for people who have a specific reason to want to host the font themselves. For most web designers, [Google Web Fonts](http://www.google.com/fonts/) uses the same technique and lets you take advantage of browser caching and Google's CDN to speed up font loading. Unless you have a specific need for a downloadable webfont kit, I recommend giving Web Fonts a try.*

[Open Sans](http://en.wikipedia.org/wiki/Open_Sans) is a really great sans-serif font commissioned by Google and available under the Apache license. Lately, I've found myself using it for all kinds of projects on the web, including this site. While there are many kits available to use Open Sans with the industry-standard @font-face CSS webfont embedding, most webfont vendors and sites like [fontsquirrel](http://www.fontsquirrel.com/) use different font-family names to differentiate between regular, italic, and bold versions of the fonts. This means that you would have to re-declare the font-family every time you wanted italic or bold text, and just isn't a very robust solution. Plus, juggling 5-10 font-families makes it hard to keep your CSS simple and manageable. 

## FontSquirrel Implementation:  
{% highlight css %}
@font-face {
    font-family: 'OpenSansLight';
    src: url('OpenSans-Light-webfont.eot');
    /* src fallbacks ommitted for brevity */
    font-weight: normal;
    font-style: normal;
}
@font-face {
    font-family: 'OpenSansLightItalic';
    src: url('OpenSans-LightItalic-webfont.eot');
    /* src fallbacks ommitted for brevity */
    font-weight: normal;
    font-style: normal;
}
@font-face {
    font-family: 'OpenSansRegular';
    src: url('OpenSans-Regular-webfont.eot');
    /* src fallbacks ommitted for brevity */
    font-style: normal;
}
{% endhighlight %}

This is problematic for many reasons. For example, if I were to set `body {font-family: 'OpenSansRegular';}`, I would get faux-italics on all the `<em>` elements on the page ([not good](http://www.alistapart.com/articles/say-no-to-faux-bold/)). To fix it, I would have to set `font-style: normal; font-family: 'OpenSansItalic'` on the `<em>` elements. This is ugly css.

Fortunately, the [CSS3 working spec](http://www.w3.org/TR/css3-fonts/#font-face-rule) for webfonts allows the use of multiple @font-face rules with the same font-family and different descriptors:

## My Implementation:  
{% highlight css %}
/* Light */
@font-face {
    font-family: 'Open Sans';
    src: url('fonts/OpenSans-Light-webfont.eot');
    /* src fallbacks ommitted for brevity */
    font-weight: 200;
    font-style: normal;
}
/* Light Italic */
@font-face {
    font-family: 'Open Sans';
    src: url('fonts/OpenSans-LightItalic-webfont.eot');
    /* src fallbacks ommitted for brevity */
    font-weight: 200;
    font-style: italic;
}
/* Regular */
@font-face {
    font-family: 'Open Sans';
    src: url('fonts/OpenSans-Regular-webfont.eot');
    /* src fallbacks ommitted for brevity */
    font-weight: normal;
    font-weight: 400;
    font-style: normal;
}
{% endhighlight %}
(You can download the complete kit, including the stylesheet and font files, [here](/downloads/opensans-fontfacekit.zip))

This approach allows the Open Sans font family to be used just like any non-embedded font in CSS, with the browser downloading and swapping in the appropriate font files when text has different `font-weight` or `font-style` attributes. This will work in all browsers which fully support the @font-face syntax. If you're interested in supporting IE 7 and 8, [this trick](http://www.smashingmagazine.com/2012/07/11/avoiding-faux-weights-styles-google-web-fonts/) from Smashing Magazine can be applied to my stylesheet.

## To Conclude  
Using multiple @font-face rule with the same `font-family` and different descriptors to embed webfonts will make your CSS cleaner, and ensure that people viewing your website see the fonts as intended, without ugly faux bolding or faux italic. I've created a font-face kit for Open Sans that does this, and you can download it [here](/downloads/opensans-fontfacekit.zip)!
