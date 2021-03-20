# ENABLE AUTOLOGIN FOR UBUNTU SERVER

In Terminal:
```bash
sudo systemctl edit getty@tty1.service
```

<br>

- It will open the Nano editor to create a Service file. Paste this inside this file
- Replace the `myusername` to the user that you want to autologin

```conf
[Service]
ExecStart=
ExecStart=-/sbin/agetty --noissue --autologin myusername %I $TERM
Type=idle
```

- Save (`CTRL+O`) and exit (`CTRL+X`)
- Reboot the server

<br>

---

Source: https://askubuntu.com/questions/819117/how-can-i-get-autologin-at-startup-working-on-ubuntu-server-16-04-1

# TROUBLESHOOTING

### I informed the wrong username
Open the terminal and edit this file
```bash
sudo nano /etc/systemd/system/getty@tty1.service.d/override.conf
```
Enter the right username, save (`CTRL+O`) and exit (`CTRL+X`)

<br>

### I informed an user that doesn't exist and now Ubuntu doesn't boot (black screen with blinking cursor)
When this happen, the only to resolve is to create a second VM with Linux and mount the Virtual HD as a secondary HD of this new VM.
Then, you can access the file `/etc/systemd/system/getty@tty1.service.d/override.conf` of the secondary HD and enter the right username.

Finally, mount the virtual HD back in the first VM and it will boot.

### I informed the right user, but Ubuntu doesn't boot (black screen with blinking cursor)
You probably made a typo when entering your username (happened to me). Do the steps from the answer above.
