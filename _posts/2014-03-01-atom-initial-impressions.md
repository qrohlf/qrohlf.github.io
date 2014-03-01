---
title: Atom Initial Impressions
layout: post
summary: Breaking in GitHub's new text editor.
date: 2014-03-01 09:28

---

So, Github has a fancy new text editor, [Atom](https://atom.io). I was lucky enough to get in on the beta, and I've been using it for all of my programming for the last two days. So far, I really like it. The UI is very similar to Sublime Text and uses many of the same key bindings, so it was pretty easy for me to get my bearings. With that said, there were definitely a few annoyances present in Atom in its out-of-the-box state, so I took those as an opportunity to see just how "modern, approachable, and hackable to the core" Atom really is.

Here's the breakdown:

# 1. Color Scheme
I use the excellent Soda theme for Sublime Text with the Monokai Soda TextMate theme for syntax highlighting. The default syntax highlighting scheme that ships with Atom is, in my opinion, far inferior to Monokai Soda, so the first order of business was to get that installed.

![atom default theme](/images/atom-initial-impressions/atom-default.png)
<span class='caption'>Atom default theme</span>

![monokai soda theme](/images/atom-initial-impressions/monokai-soda.png)
<span class='caption'>Monokai soda theme</span>

I was happy to find that Atom supports TextMate themes and provides a utility to [convert them into LESS files](https://atom.io/docs/v0.62.0/converting-a-text-mate-theme) for use as native Atom themes. This is pretty sweet. So, to install Monokai Soda in Atom, I downloaded the [Monokai Soda TextMate theme](http://buymeasoda.github.com/soda-theme/extras/colour-schemes.zip), pointed my terminal to the directory I extracted it to, and converted it with

```bash
apm init --theme ~/.atom/packages/monokai-soda --convert Monokai\ Soda.tmTheme
```

After that, I popped open Atom's preferences and activated the new syntax theme on the Themes panel. It's worth noting that Atom has graphical preferences in addition to json configuration files for various settings and key bindings. I'm not entirely sure how I feel about this, and I'm interested to see whether community plugins will tend towards using the preferences GUI or letting users specify their preferences in json.

# 2. Fonts and Font Size

The default font size on Atom is HUGE, and I'm a big fan of Adobe's Source Code Pro for code editing. Fixing both the font size and font family was pretty painless with `styles.less`:

```css
.tree-view {
  font-size: 11px;
}

.editor {
  font-family: 'Source Code Pro', sans-serif;
  font-size: 11px;
}
```

# 3. Cursor Blinking
One of the first things that bothered me when I started using Atom was that the cursor blinks at a slightly faster rate than every other app on my system. It ruined the whole "native app" feel and set me on edge.

The cursor blink period is controlled by a hard-coded value in 'Resources/app/src/cursor-view.js' inside the app package (right click Atom.app, 'Show Package Contents').

The culprit is on line 27:

```js
CursorView.blinkPeriod = 800;
```

This sets the cursor to complete a full blink cycle every 800ms. The OSX default blink period is 1000ms. Apparently that .2s difference is just enough to drive me absolutely crazy.

As of this writing, I haven't found a good way to configure this value without editing the app's source. Atom has a nice Sublime-esque JSON configuration file, but according to the [documentation](https://atom.io/docs/v0.59.0/customizing-atom#configuration-key-reference), there isn't a key to control the cursor blink rate yet. For now, I've just edited `cursor-view.js` to set the blinkPeriod to 1000ms. This will get overwritten by any updates, but for now there doesn't seem to be a better way to modify the blink behavior.

I also added the following snippet to my `styles.less` file for a slight fade transition on the cursor (just like Sublime):

```css
.editor.is-focused .cursor {
  transition: opacity .2s;
  &.blink-off {
      visibility: visible;
      opacity: 0;
  }
}
```

# 4. Tab Close Icons

The last thing that bugged me about the default theme in Atom was the tab close buttons for modified & unsaved files. They show up as an electric blue outlined circle, which kinda ruins the whole subdued monochromatic thing the theme has going.


![atom default theme](/images/atom-initial-impressions/closebutton-default.png)
<span class='caption'>Atom default modified close button</span>

![monokai soda theme](/images/atom-initial-impressions/closebutton-modified.png)
<span class='caption'>My edit</span>

I opted to change them to filled-in circles which match the tab title text color, (again, similar to Sublime). Here's the `styles.less` snippet:

```css
.tab-bar .tab.modified:not(:hover) .close-icon {
  border: 4px solid #AAA;
  border-radius: 12px;
}

.tab-bar .tab.modified:hover .close-icon {
  color: inherit;
}
```

# Conclusion

As of right now, I'm very impressed with Atom. It's the most polished HTML/CSS/JS desktop app that I've ever used, and it's fantastically hackable. As a web developer who does a lot of front-end work, being able to use LESS and Javascript to hack on my text editor is something of a dream come true, and as someone who uses git for all of my projects the git/GitHub integration is really nice to have.

There's definitely some room for improvement (Atom's soft line wrapping bugged out while I was writing this post, for example), but overall I think that Atom just might become my new favorite editor.
