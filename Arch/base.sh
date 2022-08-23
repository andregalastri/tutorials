#!/bin/sh

echo "Resolving keyring stuff"
sleep 3
echo "S" | sudo pacman-key --init
echo "S" | sudo pacman-key --populate
echo "S" | sudo pacman -Sy archlinux-keyring

echo "|||||||||||||||||  DONE  |||||||||||||||||||"
sleep 3

echo "Upgrading"
sleep 3
echo "S" | sudo pacman -Syyu

echo "|||||||||||||||||  DONE  |||||||||||||||||||"
sleep 3
echo "Installing applications"
sleep 3
echo "S" | sudo pacman -S xorg-server sddm openbox xfce4-terminal ranger thunar gvfs mousepad nano virtualbox-guest-iso virtualbox-guest-utils nitrogen polybar rofi git go

echo "|||||||||||||||||  DONE  |||||||||||||||||||"
sleep 3
echo "Installing Yay"
sleep 3
echo "S" | sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
echo "S" | makepkg -si
cd ~