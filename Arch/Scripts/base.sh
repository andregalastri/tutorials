#!/bin/sh

sudo pacman-key --init
sudo pacman-key --populate
sudo pacman -Sy archlinux-keyring

sudo pacman -Syyu
sudo pacman -S \ 
    xorg-server \
    sddm \
    openbox \
    xfce4-terminal \
    thunar \
    nano \
    ranger \
    virtualbox-guest-iso \
    virtualbox-guest-utils \
    git \
    arc-gtk-theme \

 yay -S \
    luna-icon-theme-git \
    fluent-cursor-theme-git