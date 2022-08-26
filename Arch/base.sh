#!/bin/sh

sudo sed -i "s/#ParallelDownloads = /ParallelDownloads = /g" /etc/pacman.conf

sudo pacman-key --init
sudo pacman-key --populate
(echo "S")              | sudo pacman -Sy archlinux-keyring

(echo "S")              | sudo pacman -Syyu

(echo "2"; echo "S")    | sudo pacman -S --needed sddm
(echo "S")              | sudo pacman -S --needed xorg-server \
                                                  linux-headers \
                                                  openbox \
                                                  xfce4-terminal \
                                                  ranger \
                                                  dunst \
                                                  thunar thunar-volman thunar-archive-plugin gvfs gvfs-nfs gvfs-mtp gvfs-gphoto2 gvfs-google gvfs-goa gvfs-afc ntfs-3g \
                                                  samba gvfs-smb cifs-utils \
                                                  mousepad nano \
                                                #   galculator \
                                                #   gtk2fontsel \
                                                  virtualbox-guest-iso virtualbox-guest-utils \
                                                  nitrogen \
                                                #   polybar \
                                                #   rofi \
                                                  git \
                                                  fish \
                                                  xarchiver \
                                                #   gnome-keyring \
                                                  adobe-source-code-pro-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts \
                                                  gnome-disk-utility \
                                                #   thunderbird-i18n-pt-br \
                                                #   discord \
                                                  vlc \
                                                #   filezilla \
                                                #   flameshot \
                                                #   inkscape \
                                                  gimp \
                                                #   krita \
                                                #   libreoffice-fresh-pt-br \
                                                #   tint2 \
                                                #   yt-dlp \
                                                  mate-polkit \
                                                #   gparted \
                                                  arandr \
                                                  lxinput-gtk3 \
                                                  lxappearance lxappearance-obconf \
                                                  arc-gtk-theme \
                                                  kvantum \
                                                  qt5ct \
                                                  nm-connection-editor \
                                                  gpicview \
                                                  picom \
                                                  pavucontrol

# (echo "1"; echo "S")    | sudo pacman -S --needed virtualbox

(echo "S")              | sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
(echo "S")              | makepkg -s
(echo "S")              | makepkg -i
(echo "S")              | sudo pacman -R go
yay --save --answerdiff None --answerclean None --removemake
cd ~

rm -rf ~/.cache
rm -rf ~/.git
rm -rf ~/yay

(echo "S")              | yay -S --needed rar google-chrome fsearch ttf-roboto-mono ttf-roboto

mkdir -p ~/.config/openbox/
cp -rf /etc/xdg/openbox/* ~/.config/openbox/

curl "https://raw.githubusercontent.com/andregalastri/tutorials/main/Arch/Files/autostart" -o autostart
mv autostart ~/.config/openbox/autostart

curl "https://raw.githubusercontent.com/andregalastri/tutorials/main/Arch/Files/smb.conf" -o smb.conf
sudo mv smb.conf /etc/samba/smb.conf
sudo sed -i "s/netbios name = <add-name-here>/netbios name = $HOSTNAME/g" /etc/samba/smb.conf


curl "https://raw.githubusercontent.com/andregalastri/tutorials/main/Arch/Files/arc-openbox.tar.gz" -o arc-openbox.tar.gz
curl "https://raw.githubusercontent.com/andregalastri/tutorials/main/Arch/Files/fluent-cursors.tar.gz" -o fluent-cursors.tar.gz
curl "https://raw.githubusercontent.com/andregalastri/tutorials/main/Arch/Files/flat-remix-icons.tar.gz" -o flat-remix-icons.tar.gz


tar -xzf arc-openbox.tar.gz -C /usr/share/themes/
tar -xzf fluent-cursors.tar.gz -C /usr/share/icons/
tar -xzf flat-remix-icons.tar.gz -C /usr/share/icons/


echo "QT_QPA_PLATFORMTHEME=qt5ct" | sudo tee -a /etc/environment
echo "GTK_THEME=Arc-Lighter" | sudo tee -a /etc/environment

sudo systemctl enable sddm smb nmb avahi-daemon
