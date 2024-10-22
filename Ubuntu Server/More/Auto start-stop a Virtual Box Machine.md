# AUTOSTART A VIRTUAL BOX MACHINE
- Insert this command in the startup settings
```bash
vboxmanage startvm "Name of your machine" --type=headless
```

# AUTOSTOP A VIRTUAL BOX MACHINE
- Insert this command in the shutdown script
```bash
vboxmanage controlvm "Name of your machine" acpipowerbutton
```
