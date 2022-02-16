
# ENABLING DROIDCAM OBS TO DETECT ANDROID SMARTPHONES ON LINUX

---

**First of all** you need to enable the Developer Options and the USB-Debugging Option in your Android. The steps to enable it changes between the various Android versions and manufacturers, so, please, search for how to do this based on your smartphone.

Only follow the following steps after enabling those options.

---

1. Install ADB:
```bash
sudo apt-get install android-tools-adb
```

2. Connect the smartphone in the computer and run ADB to detect it:
```bash
sudo adb devices
```

3. In the smartphone, a popup window will be shown, like the following one. Choose *Always allow from this computer* and then *OK* or *Yes*.
![image](https://user-images.githubusercontent.com/49572917/154352738-da63df90-6062-4a34-a2ff-b15554330297.png)

Now Droidcam OBS will detect your smartphone by USB connection.
