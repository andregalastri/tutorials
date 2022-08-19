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
* Reboot

## SOFTWARE INSTALLATION
* Logon using your passworkd
* Right click on any part of the blackscreen
* Select `Terminals > Xfce-Terminal`
  ![image](https://user-images.githubusercontent.com/49572917/185463816-7ade56c8-f40c-4e12-9f03-2271c53553b6.png)
* Install GIT
  ```bash
  sudo pacman -S git
  ```
* Install Wget
  ```bash
  sudo pacman -S wget
  ```
* Installing Paru (AUR Helper)
It takes a long time to compile and install...
  ```bash
  sudo pacman -S --needed base-devel
  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si
  cd ~
  rm -rf paru
  ```
* Installing window decoration themes
  ```bash
  sudo pacman -S arc-gtk-theme
  ```
* Installing icon themes
  ```bash
  paru -S luna-icon-theme-git
  ```
* Installing mouse cursor themes
  ```bash
  paru -S fluent-cursor-theme-git
  ```