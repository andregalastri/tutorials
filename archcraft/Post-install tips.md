# ABOUT THE PANELS
Archcraft uses a softawre called [Polybar](https://github.com/polybar/polybar) to draw its panels. You can customize it accessing `~/.config/openbox/polybar`

# ABOUT POLYBAR
* If you want to use some module in your panel, you need to check if it is defined in the *module.ini* file.
* If you are changing an existent theme, run the *launch.sh* file to reload the bar and see the changes.

# INSTALLING VIRTUALBOX

Got into some difficulties to install Virtualbox when using Archcraft, so, here are some instructions.

1. Open terminal and install Virtualbox
   ```zsh
   sudo pacman -Syu virtualbox virtualbox-guest-iso linux-headers
   ```
   It is needed to install `linux-headers` because, apparently, it isn't installed from default.
2. Reboot the PC.


