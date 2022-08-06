# POST-INSTALL TIPS
<br>

## SOFTWARE INSTALLING

1. Open terminal and run the commands below to install the following applications
   * Google Chrome
   * Visual Studio Code
   * Samba
   ```zsh
   yay -S google-chrome visual-studio-code-bin samba
   ```
1. Download the default file `smb.conf` for Samba
   ```zsh
   
   curl -o smb.conf "https://raw.githubusercontent.com/andregalastri/tutorials/main/archcraft/Files/smb.conf"
   sudo mv smb.conf /etc/samba/smb.conf
   ```
1. Install Warsaw
   ```zsh
   yay -S warsaw-bin
   ```
   Choose [N]enhum when asked
1. Reboot the PC

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

<br>

## INSTALLING VIRTUALBOX

Got into some difficulties to install Virtualbox when using Archcraft, so, here are some instructions.

1. Open terminal and install Virtualbox
   ```zsh
   sudo pacman -Syu virtualbox virtualbox-guest-iso linux-headers
   ```
   It is needed to install `linux-headers` because, apparently, it isn't installed from default.
   <br><br>
1. Reboot the PC.


