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
(echo "S";echo "2") | sudo pacman -S--needed xorg-server sddm openbox xfce4-terminal ranger thunar thunar-archive-plugin gvfs mousepad nano virtualbox-guest-iso virtualbox-guest-utils nitrogen polybar rofi git fish xarchiver
(echo "S") | sudo pacman -S --needed linux-headers gnome-keyring adobe-source-code-pro-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts samba gnome-disk-utility galculator virtualbox thunderbird-i18n-pt-br discord vlc filezilla flameshot inkscape gimp krita libreoffice-fresh-pt-br tint2 yt-dlp gtk2fontsel
echo "|||||||||||||||||  DONE  |||||||||||||||||||"
sleep 3
echo "Installing Yay"
sleep 3
echo "S" | sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
(echo "S";echo "S") | makepkg -si
echo "S" | sudo pacman -R go
cd ~

rm -rf ~/.cache
mkdir -p ~/.config/openbox/
cp -rf /etc/xdg/openbox/* ~/.config/openbox/

sudo systemctl enable sddm.service

yay --save --answerdiff None --answerclean None --removemake
yay -S --needed rar fontviewer