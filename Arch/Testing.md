# PERSONAL TESTING
> **This is for personal use**
<br>

## VIRTUALBOX CONFIG TIPS
* When using Xorg, it seems that it fails to start when 3D acceleration is
  activand freezes. Need to fix this, but for now, just turned 3D acceleration off.

## BASE INSTALL
* Did a minimal install
* Reboot

<br>

## INSTALLING OPENBOX
* Installing XORG
  ```bash
  sudo pacman -S xorg-server
  ```
* Installing a login manager
  ```bash
  sudo pacman -S sddm
  ```
* Installing a window manager
  ```bash
  sudo pacman -S openbox
  ```
* Installing a terminal
  ```bash
  sudo pacman -S xfce4-terminal
  ```
* Installing a file manager
  ```bash
  sudo pacman -S thunar
  ```
* Installing a terminal editor
  ```bash
  sudo pacman -S nano
  ```
* [Optional if using Virtualbox]
  ```bash
  sudo pacman -S virtualbox-guest-iso virtualbox-guest-utils
  ```
<br>

* Enabling the login manager
  ```bash
  sudo systemctl enable sddm.service
  ```