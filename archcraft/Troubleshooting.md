# TROUBLESHOOTING
<br>

## INVALID OR CORRUPTED PACKAGE (PGP SIGNATURE)

Run the following command in terminal
```zsh
sudo pacman-key --populate archlinux
```

If it doesn't enough, run the following command
```zsh
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


## VSCODE SYNC RETURNING ERROR

After login on Github with VSCode to sync settings, VSCode returns the following error

> Writing login information to the keychain failed with error 'GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name org.freedesktop.secrets was not provided by any .service files'.

* Install Gnome Keyring:
```zsh
sudo pacman -S gnome-keyring 
```
<br>
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
  ```zsh
  sudo nano /opt/discord/resources/build_info.json
  ```
* Change the version to the most recent
* Save, close and reopen Discord

> **NOTE:** When an update are available, this file will also be updated, so don't worry.

<br>

## REMOVING PLANK ICON FROM DOCK

Run the following command in terminal
```zsh
gsettings set net.launchpad.plank.dock.settings:/net/launchpad/plank/docks/dock1/ show-dock-item false
```

<br>

## FREE FILE SYNC NOT RESPONDING

Move the window and see if there is an *About* window under that. That window prevents you from interacting with the program.

<br>

## MISSING SOME CHARACTERS

Run the following command in terminal
```zsh
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
  ```
* Save and close.

**Result**
<br>
![image](https://user-images.githubusercontent.com/49572917/183483652-9884a0a7-68e2-4933-a42c-78532c287257.png)

