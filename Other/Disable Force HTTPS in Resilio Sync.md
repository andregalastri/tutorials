# DISABLE FORCE HTTPS IN RESILIO SYNC

In terminal

**NOTE:** Change `user` to the your user

```bash
sudo systemctl edit user@tty1.service
```

<br>

I will create a new file. Paste this code inside.

**NOTE:** Change `user` to the your user

```config
[Service]
ExecStart=
ExecStart=-/sbin/agetty --noissue --autologin user %I $TERM
Type=idle
```
