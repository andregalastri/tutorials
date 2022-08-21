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

## PREPARE
* Installing XORG
  ```bash
  sudo pacman-key --init
  sudo pacman-key --populate
  sudo pacman -Sy archlinux-keyring
  ```

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
* Installing a terminal file manager
  ```bash
  sudo pacman -S ranger
  ```
* Installing a GUI file manager
  ```bash
  sudo pacman -S thunar gvfs
  ```
* Installing a GUI text editor
  ```bash
  sudo pacman -S mousepad
  ```
* Installing a terminal text editor
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

* Choose between **Yay** or **Paru**
  * Yay (AUR Helper)
    ```bash
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ~
    ```
  * Paru (AUR Helper)
    It takes a long time to compile and install...
    ```bash
    sudo pacman -S --needed base-devel
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
    cd ~
    ```
* Installing window decoration themes
  ```bash
  sudo pacman -S arc-gtk-theme
  ```
* Installing icon themes
  ```bash
  yay -S luna-icon-theme-git
  ```
* Installing mouse cursor themes
  ```bash
  yay -S fluent-cursor-theme-git
  ```