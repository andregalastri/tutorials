# POST-INSTALL TIPS
<br>

## DISABLE POWER SAVING SETTINGS
1. Search for *Gerenciador de Energia*
2. Define the options as the screens below
   <br>
   ![image](https://user-images.githubusercontent.com/49572917/183267488-6256ebc3-7a0e-4151-acbf-17675ab91604.png)
   ![image](https://user-images.githubusercontent.com/49572917/183267495-d585639b-af00-4fdf-98eb-23c1158e3a91.png)
   ![image](https://user-images.githubusercontent.com/49572917/183267498-f7ef4aee-51cf-4fbd-83e6-23c4609bd8c7.png)

<br>

## UPDATING

```zsh
  sudo pacman-key --populate archlinux
  sudo pacman -Sy archlinux-keyring
  sudo pacman -Syyu
  sudo reboot
```

<br>

## SOFTWARE INSTALLING

1. Installing softawares from main
   * Fish
   * Samba
   * Thunderbird
   * Virtualbox
   * Kernel headers
   * Filezilla
   * GIMP
   * Gnome Disks
   * VLC
   * Qalculate
   * Source Code Pro Fonts
   * Noto Fonts for missing characters
   * Flameshot
   * Inkscape
   * Krita
   * Libreoffice
   * Discord
   * File Roller
   * Gnome Keyring
   * Tint2
   ```zsh
   sudo pacman -S linux-headers
   sudo pacman -S gnome-keyring
   sudo pacman -S adobe-source-code-pro-fonts
   sudo pacman -S noto-fonts-cjk
   sudo pacman -S noto-fonts-emoji
   sudo pacman -S noto-fonts
   sudo pacman -S file-roller
   sudo pacman -S samba
   sudo pacman -S fish
   sudo pacman -S gnome-disk-utility
   sudo pacman -S qalculate-gtk
   sudo pacman -S virtualbox
   sudo pacman -S virtualbox-guest-iso
   sudo pacman -S thunderbird-i18n-pt-br
   sudo pacman -S discord
   sudo pacman -S vlc
   sudo pacman -S filezilla
   sudo pacman -S flameshot
   sudo pacman -S inkscape
   sudo pacman -S gimp
   sudo pacman -S krita
   sudo pacman -S libreoffice-fresh
   sudo pacman -S tint2
   ```
   <br>
   
   > **Note: During the installation, choose the default options when asked**<br>
   > If an unexpected error occurs, run the command again and you will be fine.
   <br>
1. Installing softawares from AUR
   * Google Chrome
   * Visual Studio Code
   * Telegram
   * Warsaw
   ```zsh
   yay -S google-chrome
   yay -S visual-studio-code-bin
   yay -S telegram-desktop
   yay -S warsaw-bin
   ```
   <br>
   
   > **Note: While installing Warsaw, choose `[N]enhum/[N]one` when asked**
   <br>
1. Other softwares
   * FreeFileSync
     * Download: https://freefilesync.org/download.php
     * Extract the file and run the `.run` script to install


<br>

## SOFTWARE REMOVING

1. Removing some applications
   * Xarchiver
   * Timeshift
   ```zsh
   sudo pacman -R xarchiver timeshift
   ```
<br>

## CONFIGURING

### Configure autostart
1. Open the file
   `~/.config/openbox/autostart`
1. Add the following command at the end of the file
   ```
   ## Telegram
   exec /usr/bin/telegram-desktop -workdir /home/andre/.local/share/TelegramDesktop/ -autostart &
   
   ## Virtualbox
   exec vboxmanage startvm "Ubuntu Server 20.04" --type=headless &
   find . -maxdepth 1 -name "*VBoxHeadless*" -delete &
   ```
1. Open Telegram and go to **Settings > Advanced**
2. Enable all startup options as following
   <br>
   ![image](https://user-images.githubusercontent.com/49572917/183298790-4b1d85bd-26e2-4ad9-95ea-774c98a757f9.png)

<br>

### Configure Samba
1. Download the default file `smb.conf` for Samba
   ```zsh
   curl -o smb.conf "https://raw.githubusercontent.com/andregalastri/tutorials/main/archcraft/Files/smb.conf"
   sudo mv smb.conf /etc/samba/smb.conf
   ```
1. Add an user to Samba. You will need to define a password (the password can be different from the real user your adding).
   ```zsh
   sudo smbpasswd -a <your-user>
   ```
1. Enable Samba service
   ```zsh
   sudo systemctl enable smb nmb
   sudo systemctl start smb nmb
   ```

<br>

## ABOUT POLYBAR
Archcraft uses a softawre called [Polybar](https://github.com/polybar/polybar) to draw its panels. You can customize it accessing `~/.config/openbox/polybar`

* If you want to use some module in your panel, you need to check if it is defined in the *module.ini* file.
* If you are changing an existent theme, run the *launch.sh* file to reload the bar and see the changes.
