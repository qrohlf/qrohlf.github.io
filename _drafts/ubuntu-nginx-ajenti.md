---
title: Setting up Ubuntu 12.04 with Nginx, Passenger, and Ajenti
layout: post
summary:
---

# Basic setup
- setup Digitalocean droplet
- login as root
- `adduser qrohlf`
- `visudo`
- `nano /etc/ssh/sshd_config`
- test ssh and sudo for new account
- on development machine add SSH alias in ~/.ssh/config
- `sudo apt-get update`
- `sudo apt-get upgrade`
- reboot (probably not needed, but doesn't hurt)
- sexy bash prompt
    - `sudo apt-get install git make`
    - ` cd /tmp`
    - `git clone --depth 1 https://github.com/twolfson/sexy-bash-prompt`
    - `cd sexy-bash-prompt`
    - `make install && . ~/.bashrc`
    - `sudo make install` #if you want a colored bash prompt as root (sudo -i) also

# Persistient root shell
All of the following commands need root. I suggest doing a `sudo -i` right now so that you don't have to type sudo in front of everything

# Nginx and Passenger
- use brightbox PPA for an installable nginx package with passenger prebuilt
- `apt-get install python-software-properties` (needed for apt-add-repository)
- `apt-add-repository ppa:brightbox/passenger-nginx` (if you only want passenger and nginx)
- OR
- `apt-add-repository ppa:brightbox/ruby-ng` for updated ruby versions
- `apt-get update`
- `apt-get install nginx-full ruby-full rubygems`
- `gem install passenger`
- `service nginx restart` #make sure nginx is running
- `http://http://192.241.227.65/` should show stock nginx page
- Check if it worked with `passenger-memory-stats`

# Ajenti
- add repo with `wget http://repo.ajenti.org/debian/key -O- | apt-key add - && echo "deb http://repo.ajenti.org/ng/debian main main" >> /etc/apt/sources.list`
- install Ajenti `apt-get update && apt-get install ajenti`
- stop Ajenti `service ajenti stop`
- `nano /etc/ajenti/config.json` and change "root" username to something else
- start Ajenti `service ajenti start`
- browse to Ajenti install (https://192.241.227.65:8000) and login with your chosen username and the password "admin"

# Ajenti reverse proxy (optional)