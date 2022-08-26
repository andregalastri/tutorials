# UNOFFICIAL TROUBLESHOOTING
<br>

## BLACK SCREEN WITH ONLY THE CURSOR SHOWING UP
You probably uninstalled **zsh** and you need to reinstall it.

*  Turn on your computer. At the GRUB screen, choose *Advanced options for Archcraft*
   ![image](https://user-images.githubusercontent.com/49572917/185158203-9d7ce680-8e81-4687-b659-248a609c4907.png)
   <br>
*  Then, select the option that shows the text *recovery mode*
*  Inform your root password
*  Run the command `dhclient` to connect to the internet
*  Reinstall zsh
   ```bash
   sudo pacman -S zsh
   ```
*  Reboot the computer using `reboot` command
*  It should work normally now.


<br>

## INVALID OR CORRUPTED PACKAGE (PGP SIGNATURE)

Run the following commands in terminal
```bash
sudo pacman-key --populate archlinux
sudo pacman -Sy archlinux-keyring
```

<br>

## ACTIVATING NUMLOCK ON BOOTUP

* Open the file `~/.config/xfce4/xfconf/xfce-perchannel-xml/keyboards.xml`
* Add the following properties to the `keyboars` channel
  ```xml
  <property name="Numlock" type="bool" value="true"/>
  <property name="RestoreNumlock" type="bool" value="true"/>
  ```
  
  **Like this**
  ```xml
  <?xml version="1.0" encoding="UTF-8"?>

  <channel name="keyboards" version="1.0">
    <property name="Default" type="empty">
      <property name="Numlock" type="bool" value="true"/>
      <property name="RestoreNumlock" type="bool" value="true"/>
    </property>
  </channel>
  ```
* Save and close and reboot.

<br>

## FLICKERING ISSUES

* Edit the file `~/.config/picom.conf`
* Search for `use-damage` and set it to `false`
* Save and close. No need  to reboot or logout/login

<br>

## PASSWORD FEEDBACK WHEN SUDO

* Run `sudo EDITOR=nano visudo`
* Search for a `Defaults` without a `#` in front of it.
  > If there is no `Defaults` uncommented, just add a new line and type `Defaults`
* Add a new value `pwfeedback` in front of it. It may look something like this
  ```config
  Defaults env_reset, pwfeedback
  ```
  Or
  ```config
  Defaults pwfeedback
  ```
* Save and close.

<br>


## VSCODE SYNC RETURNING ERROR

After login on Github with VSCode to sync settings, VSCode returns the following error

> Writing login information to the keychain failed with error 'GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name org.freedesktop.secrets was not provided by any .service files'.

* Install Gnome Keyring:
  ```bash
  sudo pacman -S gnome-keyring 
  ```
  
* Try sync again
  > **NOTE: If it asks for to create a password, leave it in blank and confirm.**

<br>

## MOUSE CURSOR THEMES NOT PERSISTING

* Delete this file `~/.icons/default/index.theme`
* Open **LxAppearance** and choose the theme you want and click on **__Apply__**.<br>
  > **Note:** You can open LXAppearance running `lxappearance` in the terminal
* Now open **XFCE Settings Manager**<br>
  > **Note:** You can open XFCE Settings Manager running `xfce4-settings-manager` in the terminal
* There, select **Mouse and touchpad**
* Select the *Theme* tab and choose the same theme you selected in the LxAppearance.
* Close everything and reboot.

<br>

## DISCORD HAS AN UPDATE THAT ISN'T AVAILABLE IN THE REPOSITORY

* Trick the application by editing the `build_info.json` file. Run:
  ```bash
  sudo nano /opt/discord/resources/build_info.json
  ```
* Change the version to the most recent
* Save, close and reopen Discord

> **NOTE:** When an update are available, this file will also be updated, so don't worry.

<br>

## REMOVING PLANK ICON FROM DOCK

Run the following command in terminal
```bash
gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ show-dock-item false
```

<br>

## FREE FILE SYNC NOT RESPONDING

Move the window and see if there is an *About* window under that. That window prevents you from interacting with the program.

<br>

## MISSING SOME CHARACTERS

Run the following command in terminal
```bash
sudo pacman -S noto-fonts-cjk noto-fonts-emoji noto-fonts
```

<br>

## WORKAROUND FOR WEIRD SHADOW AT MENUS

Some shadows are shown glitchy and weird, like in Firefox or VLC, like this:
<br>
![image](https://user-images.githubusercontent.com/49572917/183482988-21409a4d-938e-4790-9377-b0e33c9af5c2.png)

The only way I found to make it less annoying is by removing the shadow from these types of menus.

* Open Kvantum
* Choose to disable composite effects
  ![image](https://user-images.githubusercontent.com/49572917/183791230-1a71118c-363b-4840-a275-917484b045c9.png)
<br>

* Open the file `~/.config/picom.conf`
* Locate the array `shadow-exclude`
* Add these keys and values to the array:
  ```
  "class_g = 'firefox' && window_type = 'menu'",
  "class_g = 'firefox' && window_type = 'dropdown_menu'",
  "class_g = 'firefox' && window_type = 'popup_menu'",
  "class_g = 'firefox' && window_type = 'tooltip'",
  "class_g = 'xdg-desktop-portal-gnome' && window_type = 'menu'",
  "class_g = 'baobab' && window_type = 'menu'",
  "class_g = 'gnome-font-viewer' && window_type = 'menu'",
  "_NET_WM_WINDOW_TYPE:a *= '_KDE_NET_WM_WINDOW_TYPE_OVERRIDE'",
  ```
* Save and close.

**Result**
<br>
![image](https://user-images.githubusercontent.com/49572917/183483652-9884a0a7-68e2-4933-a42c-78532c287257.png)

<br>

## OBS WITH WRONG OR WEIRD THEME

* Open Kvantum
* Choose Application themes
* Choose the KvFlat theme and write `obs` in the field<br>
  ![image](https://user-images.githubusercontent.com/49572917/185744665-e1c12d52-b440-40b3-a819-f6960648848d.png)<br><br>
* Click save, close and then reopen OBS.

<br>

## PERMISSION DENIED FOR SHARED FOLDERS ON VIRTUAL BOX

On the guest side, run the following command
```bash
sudo usermod -aG vboxsf $USER
```

Reboot the guest side

<br>

## REMOVING ALACRITTY
<br>

> **ATTENTION: Some submenus or items from Openbox may not work properly**

<br>

Run the following command in terminal
```bash
sudo mkdir -p /usr/share/archcraft_bak
sudo cp -rfp /usr/share/archcraft/* /usr/share/archcraft_bak
sudo pacman -R alacritty archcraft-bspwm archcraft-openbox
sudo cp -rfp /usr/share/archcraft_bak/* /usr/share/archcraft
sudo rm -rf /usr/share/archcraft_bak
```

<br>

## REMOVING GEANY
<br>

> **ATTENTION: Some submenus or items from Openbox may not work properly**

<br>

Run the following command in terminal
```bash
sudo mkdir -p /usr/share/archcraft_bak
sudo cp -rfp /usr/share/archcraft/* /usr/share/archcraft_bak
sudo pacman -R geany geany-plugins archcraft-bspwm archcraft-openbox
sudo cp -rfp /usr/share/archcraft_bak/* /usr/share/archcraft
sudo rm -rf /usr/share/archcraft_bak
```

<br>

## REMOVING ALL ARCHCRAFT REPOSITORIES (DANGEROUS)
<br>

> **ATTENTION: It may break your system. Only do this if you understand the risks of doing so.**

<br>

Run the following command in terminal
```bash
sudo mkdir -p /usr/share/archcraft_bak
sudo mkdir -p /usr/share/backgrounds_bak
sudo mkdir -p /usr/share/fonts_bak
sudo mkdir -p /usr/share/icons_bak
sudo mkdir -p /usr/share/themes_bak
sudo mkdir -p /etc/grub.d_bak
sudo mkdir -p /usr/share/sddm/themes_bak

sudo cp -rfp  /usr/share/archcraft/* /usr/share/archcraft_bak
sudo cp -rfp  /usr/share/backgrounds/* /usr/share/backgrounds_bak
sudo cp -rfp  /usr/share/fonts/* /usr/share/fonts_bak
sudo cp -rfp  /usr/share/icons/* /usr/share/icons_bak
sudo cp -rfp  /usr/share/themes/* /usr/share/themes_bak
sudo cp -rfp  /etc/grub.d/* /etc/grub.d_bak
sudo cp -rfp  /usr/share/sddm/themes/* /usr/share/sddm/themes_bak

sudo pacman -R $(pacman -Q | grep -E '^archcraft' | awk '{print $1}')

sudo mkdir -p /usr/share/archcraft
sudo mkdir -p /usr/share/backgrounds
sudo mkdir -p /usr/share/fonts
sudo mkdir -p /usr/share/icons
sudo mkdir -p /usr/share/themes
sudo mkdir -p /etc/grub.d
sudo mkdir -p /usr/share/sddm/themes

sudo cp -rfp  /usr/share/archcraft_bak/* /usr/share/archcraft
sudo cp -rfp  /usr/share/backgrounds_bak/* /usr/share/backgrounds
sudo cp -rfp  /usr/share/fonts_bak/* /usr/share/fonts
sudo cp -rfp  /usr/share/icons_bak/* /usr/share/icons
sudo cp -rfp  /usr/share/themes_bak/* /usr/share/themes
sudo cp -rfp  /etc/grub.d_bak/* /etc/grub.d
sudo cp -rfp  /usr/share/sddm/themes_bak/* /usr/share/sddm/themes

sudo rm -rf /usr/share/archcraft_bak
sudo rm -rf /usr/share/backgrounds_bak
sudo rm -rf /usr/share/fonts_bak
sudo rm -rf /usr/share/icons_bak
sudo rm -rf /usr/share/themes_bak
sudo rm -rf /etc/grub.d_bak
sudo rm -rf /usr/share/sddm/themes_bak
```

Then, open the following file and remove Archcraft repository from there.
```bash
sudo nano /etc/pacman.conf
```



