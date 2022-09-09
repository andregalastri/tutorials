#!/bin/sh

gsettings set org.nemo.preferences enable-delete true
xdotool keyup Control
xdotool keyup Delete
sleep 0.2
xdotool keydown Shift+Delete
sleep 0.2
gsettings set org.nemo.preferences enable-delete false
xdotool keyup Delete
xdotool keyup Shift