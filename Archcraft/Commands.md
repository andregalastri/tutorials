# COMMANDS
Here are some commands that differs from APT and Ubuntu-based distros.

<br>

## UPDATE REPOSITORIES AND UPGRADE

```bash
sudo pacman -Syyu
```

<br>


## CLEAR PACMAN CACHE

```bash
sudo pacman -Scc
```

<br>

## CHECK THE MIME TYPE

Run the following command in terminal
```bash
xdg-mime query filetype <file-path>
```

<br>

## UPDATE GRUB

Run the following command in terminal
```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

<br>

## RUN APPLICATION AS ROOT (OR OTHER USER) USING POLKIT DIALOG TO ASK FOR PASSWORD

Run the following command in terminal
```bash
pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY <application-name>
```

<br>

## DISABLE YAY FROM ASKING FOR SHOW DIFFS 

Run the following command in terminal
```bash
yay --save --answerdiff None --answerclean None --removemake
```

### I want to restore it
To restore it, remove the config file from Yay
```bash
rm -rf ~/.config/yay/config.json
```
<br>

