# PULSEAUDIO NOISE REDUCTION

1. Open this file as root:
**/etc/pulse/default.pa**

2. Insert this at the bottom of the file
```
.ifexists module-echo-cancel.so
load-module module-echo-cancel channels=2 aec_method=webrtc aec_args="analog_gain_control=0 digital_gain_control=0" source_name=lineinoiseless source_properties=device.description=LineInNoiseless
.endif
```

3. Open the terminal and type
```
pulseaudio -k
```

4. Change the input to the new device
![image](https://user-images.githubusercontent.com/49572917/128580652-15ba4739-9e7f-4c0c-bb7d-9a5a416970a8.png)
