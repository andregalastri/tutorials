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
