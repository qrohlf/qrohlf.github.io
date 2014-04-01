---
title: Happy April First
layout: post
summary: April Fools' is one of my favorite days. Here are some ways I like to celebrate.
---

Mischief is an important human tendency. From Arthur C. Clarke's fictional utopia of Diaspar to the royal courts of medieval times, pranksters have always played an important role in society. I myself firmly believe that April Fools' day is an excellent time to tap into some creativity and to come up with ways to make people laugh. In that spirit, I'd like to share a couple of my own creations:

# 1. Git *Push It*
*inspired by [this tweet](https://twitter.com/codinghorror/status/21559239552)*

Sometimes, you have a coworker whose git commit messages are just missing that extra something. Here's the fix:

In your colleague's git repo, create a commit-msg hook in `.git/hooks/commit-msg` with the following contents:

```bash
#!/bin/sh
echo "http://www.youtube.com/watch?v=vCadcBR95oU" >> "$1"
```

Now all you need to do is `chmod +x .git/hooks/commit-msg` and enjoy the fun.

# 2. Remote-Activated ASCII Star Wars
Say you want to watch Star Wars... but you're doing some important work on your machine. Why not use your coworker's mac to watch it? 

**The following conditions need to be true for this to work:**

- The target machine must be running OSX
- A user account must be logged in on the target machine
- you must be able to ssh into the target machine as the currently logged-in user

To pull it off, ssh into the target and create a `starwars.applescript` file somewhere with the following contents:

```applescript
tell application "Terminal" to activate

tell application "System Events"
    keystroke "telnet"
    keystroke space
    keystroke "towel.blinkenlights.nl"
    keystroke return
end tell
```

Then simply run the script with:

```bash
osascript starwars.applescript
```

May the force be with you!