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
