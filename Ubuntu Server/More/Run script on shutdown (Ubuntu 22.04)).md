# RUN SCRIPT ON SHUTDOWN (UBUNTU 22.04)

<br>

## 1. CREATE THE SCRIPT
- Open a terminal and create a file
```
sudo nano /usr/local/bin/shutdown_script.sh
```

- Add the command you want to run on shutdown
```
#!/bin/bash
echo "Running the shutdown script" >> /var/log/shutdown_script.log
```

- Make the script executable
```
sudo chmod +x /usr/local/bin/shutdown_script.sh
```

<br>

## 2. CREATE A SERVICE FILE FOR SYSTEMD
- Open a terminal and create a file
```
sudo nano /etc/systemd/system/shutdown_script.service
```

- Insert the following code, save and close
```
[Unit]
Description=Run a script on shutdown
DefaultDependencies=no
Before=shutdown.target reboot.target halt.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/shutdown_script.sh
RemainAfterExit=true

[Install]
WantedBy=halt.target reboot.target shutdown.target
```

- Enable the service
```
sudo systemctl enable shutdown_script.service
```

---

If your script has the same code in this example, when you shutdown or restart your computer, you will see that the file at `/var/log/shutdown_script.log` will have the message "Running the shutdown script".
