# TROUBLESHOOTING
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

## MISSING JAPANESE FONTS

Run the following command in terminal
```zsh
sudo pacman -S noto-fonts-cjk noto-fonts-emoji noto-fonts
```
