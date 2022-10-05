#!/bin/sh

function Command() {
    echo -en ">> $1\n\n";
    sleep 1;
};

function Done() {
    echo -en "\n\n>> DONE!\n";
    sleep 1;
};


echo "########################################";
echo "#            Ainad Install             #";
echo "########################################";

#---------------

Command "ENABLING PARALLEL DOWNLOADS
All it does is uncomment the ParallelDownloads parameter from pacman.conf.";

sudo sed -i "s/#ParallelDownloads = /ParallelDownloads = /" "/etc/pacman.conf";

Done;

#---------------

Command "PREPARING PACMAN-KEY
Initiates, populates and installs keying to resolve issues with PGP key validations while using Pacman.";

sudo pacman-key --init;
sudo pacman-key --populate;
(echo "y") | LANG=C sudo pacman -Sy --needed archlinux-keyring;

Done;

#---------------

Command "UPDATING THE WHOLE SYSTEM
Updates all installed packages.";

(echo "y") | LANG=C sudo pacman -Syyu;

Done;

#---------------

Command "INSTALLING SDDM
Installs the login manager SDDM and a theme. SDDM allows to create better visuals for login, that is why I'm using it. It also have wondeful themes made by the community.";

(echo "2"; echo "y") | LANG=C sudo pacman -S --needed sddm;

Done;

#---------------

Command "INSTALLING YAY
Yay is a helper to install applications and packages that are in the AUR (the user repository of Arch Linux). You can use it like pacman, but the range of the applications and packages available are bigger. Requires some sense about intalling obscure stuff, but seems to be safe in general.";

(echo "y") | LANG=C sudo pacman -S --needed base-devel;
git clone https://aur.archlinux.org/yay.git;
cd yay;
(echo "y") | LANG=C makepkg -s --clean;
(echo "y") | LANG=C makepkg -i;
(echo "y") | LANG=C sudo pacman -R go;
yay --save --answerdiff None --answerclean None --removemake;
cd "$HOME";
rm -rf "$HOME/.cache";
rm -rf "$HOME/.git";
rm -rf "$HOME/yay";

Done;

#---------------

Command "INSTALLING APPLICATIONS
Installs everything that is needed to make this computer really useful.";

# XORG
# Install Xorg Server, to be able to draw an UI
packages+=("xorg-server xorg-xev")

# LINUX KERNEL HEADERS
# The headers act as an interface between internal kernel components and also between userspace and the kernel. Packages like sys-libs/glibc depend on the kernel headers. Source: https://wiki.gentoo.org/wiki/Linux-headers. It is also needed by Virtualbox if you are using it, so, I thing that there are other applications that uses it.
packages+=("linux-headers")

# OPENBOX
# A solid and lightweight window manager. This thing communicates with Xorg to draw windows and its contents on screen.
packages+=("openbox")

# XDOTOOL
# Command line application to automate things like keyboard shortcut execution and other stuff.
packages+=("xdotool")

# WMCTRL
# Command line application to control windows.
packages+=("wmctrl")

# XFCE TERMINAL
# A good terminal emulator that is easy to configure and gives good amount of personalization settings
# I also tried
# - lxterminal: Very lightweight, but don't have an option to set a default shell.
# - gnome-terminal: The only reason is to use it if using other Gnome apps, because of design consistency.
packages+=("xfce4-terminal")

# RANGER
# A terminal file manager. It's good to have an easy way to navigate between directories while in terminal.
packages+=("ranger")

# FISH
# A waaaaaaay better shell for terminal. Kinda like it a lot!
packages+=("fish")

# NEMO FILE MANAGER
# GUI file manager. Tested a lot of these file managers, and Nemo seems to have things that I appreciete.
# - Has an built-in search, which allows you to find directories and files without using a separated application
# - Allows to change many aspects of the context menu by creating Nemo Actions.
# - Have consistent design with the rest of the applications
#
# The problem is that it doesn't have integration with xarchive, so, I needed to create an Nemo Action for that.
#
# I tried several others, here are my thoughts
# - Nautilus - Good, but is visually inconsistent with the other applications
# - Thunar - No built-in search and have lots of inconsistent design in its own dialogs. Kinda liked thought.
# - PCManFM - Very lightweight, but the "Open With" is shown right in the main context menu, making it poluted. Also, I didn't like that it shades the column that is sorting the files.
packages+=("nemo cinnamon-translations")

# ENGRAMPA
# Allows to manage compressed files and to compress files.
# I tried Xarchiver, but I didn't like how it works, seems a bit buggy.
packages+=("engrampa")

# MATE POLKIT
# Needed when running any application or command that requires to executed in ROOT. I tried all the others, but the Mate one has the better visuals.
packages+=("mate-polkit")

# PACKAGES FOR FILE SYSTEM FORMATS AND INTEGRATION WITH FILE MANAGERS
# The main package is gvfs, which allows you to have a trash bin and mount drives directly from the file manager. The gvfs-nfs, in theory, allows better integration with network navigation. The others are only to give support for some special file system formats out of the box.
packages+=("gvfs gvfs-nfs gvfs-mtp gvfs-gphoto2 gvfs-google gvfs-goa gvfs-afc ntfs-3g")

# GNOME DISKS
# I didn't find any other application that do the things Gnome Disks does. Unfortunately, its visuals are inconsistent with the rest of the other applications, but, oh boy!
packages+=("gnome-disk-utility")

# GPARTED
# Good application to manage partitions. Gnome Disks doesn't have many options regarding this. I think that Gnome Disks is better for benchmark, change the mount and dismount configuration of drives and other stuff, but what regards partition manage and formatting, I think that Gparted is better.
packages+=("gparted")

# SAMBA
# Allows sharing directories to the network and also access to shares from Windows systems.
packages+=("samba gvfs-smb cifs-utils")

# MOUSEPAD
# GUI text editor to edit some text files. If you want something for programming, I recommend using a real code editor, this one is really simple.
packages+=("mousepad")

# NANO
# Terminal text editor to edit some text files while in command line. I don't like VIM.
packages+=("nano")

# GALCULATOR
# A simple calculator. I tried Qalculate, but it is overly complicated for a simple calculator.
packages+=("galculator")

# VIRTUALBOX GUEST PACKAGES
# While using Virtualbox, if you don't have these packages, Xorg will not start. They also allow better integration with the VM.
# NOTE: It is still needed to install the additional guest packages.
packages+=("virtualbox-guest-iso virtualbox-guest-utils")

# VIRTUALBOX
# Creates VMs with many options. I always used it, so I'm used to use Virtualbox instead of other applications for virtualization.
packages+=("virtualbox virtualbox-host-dkms")

# NITROGEN
# A simple software to change the wallpaper in Openbox.
packages+=("nitrogen")

# GIT
# It is good to have this out of the box.
packages+=("git")

# PACMAN SCRIPTS
# Install some scripts that is used in the Polybar to check updates.
packages+=("pacman-contrib")

# GNOME KEYRING
# Required by some programs, like VS Code, when connecting to a remote server via SSH.
packages+=("gnome-keyring")

# GTK2FONTSEL
# Software to browse installed fonts. It is pretty simple and lightweight. I also tried gnome-font-viewer, but it uses libadwaita which breaks the design consistency.
packages+=("gtk2fontsel")

# DUNST
# A simple and customizable notification daemon.
packages+=("dunst")

# POLYBAR
# Allows to create simple and customizable text based panels.
packages+=("polybar")

# ROFI & DMENU
# Allows to create customizable applets, menus and other stuff. Seems to be very customizable.
packages+=("rofi dmenu")

# THUNDERBIRD
# An email client to receive emails. I liked it. It is installing the PT-BR version, so I need to create an script that detects the user locale to select the right package.
packages+=("thunderbird-i18n-pt-br")

# DISCORD
# Comunitcation software used for gamers. It is like Slack or Teamspeak.
packages+=("discord")

# VLC
# The best video player, there is no other like this.
packages+=("vlc")

# FILEZILLA
# A FTP client to connect to FTP servers.
#packages+=("filezilla")

# FLAMESHOT
# The best screenshot software out there. Allows you to take the screenshot, draw arrows and other stuff in the screen before save and copy to the clipboard.
packages+=("flameshot")

# INKSCAPE
# Good vector based image editor. Allows to edit SVGs and other stuff. It is like CorelDRAW and Illustrator, but simpler.
packages+=("inkscape")

# GIMP
# Image manipulator, like Photoshop.
packages+=("gimp")

# KRITA
# Good software for drawing. It can act like an image manipulator, but has less features than Gimp regarding this aspect.
packages+=("krita")

# VIEWNIOR
# Simple image viewer with native integration with Nitrogen and good user experience.
# I tried Ristretto and Gpicview, but they don't have integration with Nitrogen and they have the default behavior of going to the next/previous images of the folder when mouse scroll and I don't like that. I like that when I scroll the mouse, the image zoom-in/zoom-out.
packages+=("viewnior")

# XREADER
# Good document viewer (PDF). Has annotations out of the box.
packages+=("xreader")

# LIBREOFFICE
# Office suite. I tested Open Office and it looks better than Libre Office, but this last one have softawares like Drawing, with I like because allows to create diagrams. I also think that it has better compatibility with Microsoft Office files, but I didn't test it enough. It also needs to check the user's locale to install the right language pack.
# Also, this installs the fresh version because I want the least features on it. Still version is more stable in theory.
packages+=("libreoffice-fresh-pt-br")

# TINT2
# Like Polybar, creates panels, but not text based. I installed it to use as a dock. I tried Plank, but I find that Tint2 has more configuration options.
#packages+=("tint2")

# YT-DLP
# A command line Youtube Video Downloader. I like it a lot and works better than the original.
packages+=("yt-dlp")

# ARANDR
# GUI application to manage screen displays.
packages+=("arandr")

# LXTASK
# GUI system monitor application.
packages+=("lxtask")

# LXINPUT-GTK3
# GUI application to manage mouse and keyboard.
packages+=("lxinput-gtk3")

# PAVUCONTROL
# GUI application to manage audio. Works on pipewire.
packages+=("pavucontrol")

# LXAPPEARANCE
# GUI application to change icon, widget, mouse cursor and window decoration themes. It has a GTK3 version, but it has bugs with the obconf plugin.
packages+=("lxappearance lxappearance-obconf")

# ARC THEME
# Installs the Arc Theme, updated for GTK 4.
#packages+=("arc-gtk-theme")

# KVANTUM
# Allows to apply some themes to QT applications globally AND per-application, which helps to workaround inconsistent apps, like OBS Studio.
packages+=("kvantum")

# QT SETTINGS
# Integrates with Kvantum and allows to manage fonts and other stuff regarding QT applications.
packages+=("qt5ct")

# NETWORK SETTINGS
# A GUI application to configure the network. I really don't like it because I think that it is too complex for my usage. Unfortunatelly, it seems that there aren't many options in this regards.
packages+=("networkmanager nm-connection-editor")

# PICOM
# The main fork of Compton. It is an window compositor, to allow render shadows, transparency, blur and round corner on windows and panels. I tried some forks, but they seem buggy.
packages+=("picom")

# QT5 PACKAGES
# These are dependencies for Sugar Dark SDDM Login Theme.
packages+=("qt5-graphicaleffects qt5-quickcontrols2")

# FONTS
# Installs some fonts.
packages+=("adobe-source-code-pro-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts")

# -----------------------------------------------
# APPLICATIONS FROM AUR
# -----------------------------------------------

# RAR
# Allows you to extract and compress RAR files. It automatically integrates with Xarchive.
packages+=("rar")

# GOOGLE CHROME
# Say what you want, but I like Google Chrome because it is compatible with everything and has the best Adblocks around the internet. As a user, I like that some things just work. I also tried some minimal browsers. The only one I really enjoyed was Qutebrowser, but it lacks a functional Adblock.
packages+=("google-chrome")

# VISUAL STUDIO CODE
# Code editor that I use for programming.
packages+=("visual-studio-code-bin")

# TELEGRAM
# Desktop version of Telegram messenger
packages+=("telegram-desktop-bin")

# WARSAW
# Needed if you access Internet Banking websites
packages+=("warsaw-bin")

# FREE FILE SYNC
# Application that I use to syncronize my files with my external hard drive. Good to create backups.
packages+=("freefilesync-bin")

# PARCELLITE CLIPBOARD MANAGER
# Without a clipboard manager, you copy/paste isn't persistent.
packages+=("parcellite")

# DMENU FOR NETWORK MANAGER
# Allows launch Network Manager with Dmenu
packages+=("networkmanager-dmenu-git")

# FONTS
# More fonts from AUR.
packages+=("ttf-roboto-mono ttf-roboto ttf-century-gothic nerd-fonts-noto")

(echo "y") | LANG=C yay --noprovides --answerdiff None --answerclean All --mflags --noconfirm --needed -S ${packages[*]};
fc-cache -f -v;

Done;

#---------------

Command "SETTING UP SOME DEFAULT CONFIGURATIONS
Just some copy/paste for default config of the Openbox and Picom.";

echo "[Config] Downloading configuration files.";
sleep 1;
mkdir "$HOME/ainad";
curl "https://raw.githubusercontent.com/andregalastri/tutorials/main/Arch/ainad.tar.gz" -o "$HOME/ainad.tar.gz";
tar -xzf "ainad.tar.gz" -C "$HOME/ainad";

echo "[Config] Copying files to their respective folders.";
sleep 1;
cp "$HOME/ainad/home/user/*" "$HOME";
sudo mkdir "/usr/share/ainad/home-config-defaults";
cp "$HOME/ainad/home/user/*" "/usr/share/ainad/home-config-defaults";
sudo cp "$HOME/ainad/etc/*" "/etc";
sudo cp "$HOME/ainad/usr/*" "/usr";

echo "[Samba] Setting up a default netbios name.";
sleep 1;
sudo sed -i "s/netbios name = <user-name>/netbios name = $HOSTNAME/" "/etc/samba/smb.conf";

echo "[Dconf] Setting XFCE Terminal as default terminal emulator for Nemo.";
sleep 1;
gsettings set org.cinnamon.desktop.default-applications.terminal exec xfce4-terminal;
sudo dbus-launch gsettings set org.cinnamon.desktop.default-applications.terminal exec xfce4-terminal;

echo "[Dconf] Settings default Nemo preferences.";
sleep 1;
gsettings set org.nemo.preferences enable-delete false;
gsettings set org.nemo.preferences confirm-move-to-trash true;
gsettings set org.nemo.preferences default-folder-viewer list-view;
gsettings set org.nemo.preferences enable-delete false;
gsettings set org.nemo.preferences inherit-folder-viewer false;
gsettings set org.nemo.preferences size-prefixes 'base-10';
gsettings set org.nemo.preferences show-location-entry true;
gsettings set org.nemo.preferences show-show-thumbnails-toolbar false;
gsettings set org.nemo.preferences thumbnail-limit 15728640;

Done;

#---------------

Command "ENABLING SERVICES
Enabling services to run at startup.";

sudo systemctl enable sddm smb nmb avahi-daemon NetworkManager systemd-homed

Done;

#---------------

Command "END OF THE SCRIPT
Everything was intalled. Just run 'reboot' to restart the computer and voilá!";


# echo ">> INSTALLING ADDITIONAL APPLICATIONS"
# echo "Installs more applications from AUR."
# sleep 2
#     packages=(" ")

#     # RAR
#     # Allows you to extract and compress RAR files. It automatically integrates with Xarchive.
#     packages+=("rar")

#     # GOOGLE CHROME
#     # Say what you want, but I like Google Chrome because it is compatible with everything and has the best Adblocks around the internet. As a user, I like that some things just work. I also tried some minimal browsers. The only one I really enjoyed was Qutebrowser, but it lacks a functional Adblock.
#     packages+=("google-chrome")

#     # VISUAL STUDIO CODE
#     # Code editor that I use for programming.
#     packages+=("visual-studio-code-bin")

#     # TELEGRAM
#     # Desktop version of Telegram messenger
#     packages+=("telegram-desktop")

#     # WARSAW
#     # Needed if you access Internet Banking websites
#     packages+=("warsaw-bin")

#     # FREE FILE SYNC
#     # Application that I use to syncronize my files with my external hard drive. Good to create backups.
#     packages+=("freefilesync-bin")

#     # PARCELLITE CLIPBOARD MANAGER
#     # Without a clipboard manager, you copy/paste isn't persistent.
#     packages+=("parcellite")

#     # DMENU FOR NETWORK MANAGER
#     # Allows launch Network Manager with Dmenu
#     packages+=("networkmanager-dmenu-git")

#     # FONTS
#     # More fonts from AUR.
#     packages+=("ttf-roboto-mono ttf-roboto ttf-century-gothic nerd-fonts-noto")

#     (echo "y") | LANG=C yay -S --needed ${packages[*]}
#     fc-cache -f -v
# echo " "
# echo ">> DONE!"
# echo " "
# sleep 1