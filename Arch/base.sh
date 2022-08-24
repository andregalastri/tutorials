#!/bin/sh

sudo pacman-key --init
sudo pacman-key --populate
(echo "S")              | sudo pacman -Sy archlinux-keyring

(echo "S")              | sudo pacman -Syyu

(echo "2"; echo "S")    | sudo pacman -S --needed sddm
(echo "1"; echo "S")    | sudo pacman -S --needed virtualbox
(echo "S")              | sudo pacman -S --needed xorg-server \
                                                  openbox \
                                                  xfce4-terminal \
                                                  ranger \
                                                  thunar thunar-archive-plugin gvfs \
                                                  mousepad nano \
                                                  galculator \
                                                  gtk2fontsel \
                                                  samba \
                                                  virtualbox-guest-iso virtualbox-guest-utils \
                                                  nitrogen \
                                                  polybar \
                                                  rofi \
                                                  git \
                                                  fish \
                                                  xarchiver \
                                                  linux-headers \
                                                  gnome-keyring \
                                                  adobe-source-code-pro-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts \
                                                  gnome-disk-utility \
                                                  thunderbird-i18n-pt-br \
                                                  discord \
                                                  vlc \
                                                  filezilla \
                                                  flameshot \
                                                  inkscape \
                                                  gimp \
                                                  krita \
                                                  libreoffice-fresh-pt-br \
                                                  tint2 \
                                                  yt-dlp

(echo "S")              | sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
(echo "S")              | makepkg
(echo "S")              | makepkg -si
(echo "S")              | sudo pacman -R go
yay --save --answerdiff None --answerclean None --removemake
cd ~

rm -rf ~/.cache
rm -rf ~/yay

yay -S --needed rar

mkdir -p ~/.config/openbox/
cp -rf /etc/xdg/openbox/* ~/.config/openbox/

sudo systemctl enable sddm.service
