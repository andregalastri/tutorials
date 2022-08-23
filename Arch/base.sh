#!/bin/sh

sudo pacman-key --init
sudo pacman-key --populate
(echo "S")              | sudo pacman -Sy archlinux-keyring

(echo "S")              | sudo pacman -Syyu

(echo "S")              | sudo pacman -S --needed xorg-server
(echo "2"; echo "S")    | sudo pacman -S --needed sddm
(echo "S")              | sudo pacman -S --needed openbox
(echo "S")              | sudo pacman -S --needed xfce4-terminal
(echo "S")              | sudo pacman -S --needed ranger
(echo "S")              | sudo pacman -S --needed thunar thunar-archive-plugin gvfs
(echo "S")              | sudo pacman -S --needed mousepad nano
(echo "S")              | sudo pacman -S --needed galculator
(echo "S")              | sudo pacman -S --needed gtk2fontsel
(echo "S")              | sudo pacman -S --needed samba
(echo "S")              | sudo pacman -S --needed virtualbox-guest-iso virtualbox-guest-utils
(echo "1"; echo "S")    | sudo pacman -S --needed virtualbox
(echo "S")              | sudo pacman -S --needed nitrogen
(echo "S")              | sudo pacman -S --needed polybar
(echo "S")              | sudo pacman -S --needed rofi
(echo "S")              | sudo pacman -S --needed git
(echo "S")              | sudo pacman -S --needed fish
(echo "S")              | sudo pacman -S --needed xarchiver
(echo "S")              | sudo pacman -S --needed linux-headers
(echo "S")              | sudo pacman -S --needed gnome-keyring
(echo "S")              | sudo pacman -S --needed adobe-source-code-pro-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts
(echo "S")              | sudo pacman -S --needed gnome-disk-utility
(echo "S")              | sudo pacman -S --needed thunderbird-i18n-pt-br
(echo "S")              | sudo pacman -S --needed discord
(echo "S")              | sudo pacman -S --needed vlc
(echo "S")              | sudo pacman -S --needed filezilla
(echo "S")              | sudo pacman -S --needed flameshot
(echo "S")              | sudo pacman -S --needed inkscape
(echo "S")              | sudo pacman -S --needed gimp
(echo "S")              | sudo pacman -S --needed krita
(echo "S")              | sudo pacman -S --needed libreoffice-fresh-pt-br
(echo "S")              | sudo pacman -S --needed tint2
(echo "S")              | sudo pacman -S --needed yt-dlp

(echo "S")              | sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
(echo "S"; echo "S")    | makepkg -si
(echo "S")              | sudo pacman -R go
yay --save --answerdiff None --answerclean None --removemake
cd ~

rm -rf ~/.cache
rm -rf ~/yay

yay -S --needed rar

mkdir -p ~/.config/openbox/
cp -rf /etc/xdg/openbox/* ~/.config/openbox/

sudo systemctl enable sddm.service
