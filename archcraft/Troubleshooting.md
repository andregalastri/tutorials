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

