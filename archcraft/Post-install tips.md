# POST-INSTALL TIPS
<br>

## UPDATING

```zsh
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
   * Libreoffice
   ```zsh
   sudo pacman -Syyu fish samba thunderbird-i18n-pt-br virtualbox virtualbox-guest-iso linux-headers filezilla gimp gnome-disk-utility vlc qalculate-gtk adobe-source-code-pro-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts flameshot inkscape libreoffice-fresh
   ```
   <br>
   
   > **Note: While installing Virtualbox, choose the default options when asked**
   <br>
1. Installing softawares from AUR
   * Google Chrome
   * Visual Studio Code
   * Telegram
   * Warsaw
   ```zsh
   yay -S google-chrome visual-studio-code-bin telegram-desktop warsaw-bin
   ```
   <br>
   
   > **Note: While installing Warsaw, choose `[N]enhum` when asked**
   <br>
1. Other softwares
   * FreeFileSync
     * Download: https://freefilesync.org/download.php
     * Extract the file and run the `.run` script to install

<br>

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
1. Enable Samba service
   ```zsh
   sudo systemctl enable smb
   ```

<br>

## DISABLE POWER SAVING SETTINGS
1. Search for *Gerenciador de Energia*
2. Define the options as the screens below
   <br>
   ![image](https://user-images.githubusercontent.com/49572917/183267488-6256ebc3-7a0e-4151-acbf-17675ab91604.png)
   ![image](https://user-images.githubusercontent.com/49572917/183267495-d585639b-af00-4fdf-98eb-23c1158e3a91.png)
   ![image](https://user-images.githubusercontent.com/49572917/183267498-f7ef4aee-51cf-4fbd-83e6-23c4609bd8c7.png)

<br>

## ABOUT POLYBAR
Archcraft uses a softawre called [Polybar](https://github.com/polybar/polybar) to draw its panels. You can customize it accessing `~/.config/openbox/polybar`

* If you want to use some module in your panel, you need to check if it is defined in the *module.ini* file.
* If you are changing an existent theme, run the *launch.sh* file to reload the bar and see the changes.
