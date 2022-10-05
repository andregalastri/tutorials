#!/bin/sh

function Command() {
    echo -en ">> $1\n\n";
    sleep 1;
};

function Done() {
    echo -en "\n\n>> DONE!\n";
    sleep 1;
};

Command "INSTALLING APPLICATIONS FROM AUR
Installs everything that is needed to make this computer really useful.";

# RAR
# Allows you to extract and compress RAR files. It automatically integrates with Xarchive.
packages+=("rar");

# GOOGLE CHROME
# Say what you want, but I like Google Chrome because it is compatible with everything and has the best Adblocks around the internet. As a user, I like that some things just work. I also tried some minimal browsers. The only one I really enjoyed was Qutebrowser, but it lacks a functional Adblock.
packages+=("google-chrome");

# VISUAL STUDIO CODE
# Code editor that I use for programming.
# packages+=("visual-studio-code-bin");

# TELEGRAM
# Desktop version of Telegram messenger
packages+=("telegram-desktop-bin");

# WARSAW
# Needed if you access Internet Banking websites
# packages+=("warsaw-bin");

# FREE FILE SYNC
# Application that I use to syncronize my files with my external hard drive. Good to create backups.
# packages+=("freefilesync-bin");

# PARCELLITE CLIPBOARD MANAGER
# Without a clipboard manager, you copy/paste isn't persistent.
packages+=("parcellite");

# DMENU FOR NETWORK MANAGER
# Allows launch Network Manager with Dmenu
packages+=("networkmanager-dmenu-git");

# FONTS
# More fonts from AUR.
packages+=("ttf-roboto-mono ttf-roboto ttf-century-gothic nerd-fonts-noto");

(echo "y") | LANG=C yay --noprovides --answerdiff None --answerclean All --mflags --noconfirm --needed -S ${packages[*]};
fc-cache -f -v;

Done;

#---------------

Command "ENABLING SERVICES
Enabling services to run at startup.";

sudo systemctl enable sddm smb nmb avahi-daemon NetworkManager systemd-homed;

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
cp -a "$HOME/ainad/home/user/." "$HOME/";
sudo mkdir -p "/usr/share/ainad/home-defaults";
sudo cp -a "$HOME/ainad/home/user/." "/usr/share/ainad/home-defaults/";
sudo cp -a "$HOME/ainad/etc/." "/etc/";
sudo cp -a "$HOME/ainad/usr/." "/usr/";

echo "[Config] Configuring NetworkManager Dmenu.";
sleep 1;
sudo "$HOME/ainad/networkmanager_dmenu_languages.sh";
sudo ln -s "/usr/share/ainad/rofi/widgets/networkmanager-dmenu" "$HOME/.config/networkmanager-dmenu";

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
gsettings set org.nemo.preferences show-compact-view-icon-toolbar false;
gsettings set org.nemo.preferences show-edit-icon-toolbar true;
gsettings set org.nemo.preferences.menu-config selection-menu-open-as-root false;
gsettings set org.nemo.preferences.menu-config background-menu-open-as-root false;

echo "[Dconf] Settings default Mousepad preferences.";
sleep 1;
gsettings set org.xfce.mousepad.preferences.view color-scheme 'classic';
gsettings set org.xfce.mousepad.preferences.view font-name 'Roboto Mono 10';
gsettings set org.xfce.mousepad.preferences.view insert-spaces true;
gsettings set org.xfce.mousepad.preferences.view show-line-numbers true;
gsettings set org.xfce.mousepad.preferences.view tab-width 4;
gsettings set org.xfce.mousepad.preferences.view use-default-monospace-font false;
Done;

#---------------

Command "END OF THE SCRIPT
Everything was intalled. Just run 'reboot' to restart the computer and voilá!";