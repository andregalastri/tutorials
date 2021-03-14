# USING A SECOND KEYBOARD TO EXECUTE MACROS IN LINUX

<br><br>

> **NOTE:
> I did this years ago.
> I didn't test this recently, I'm just putting here to store the tutorial.**

<br><br>

## GETTING STARTED

1. Access as root: `/etc/udev/rules.d/`
2. Create a file called: `70-hotkey-pad.rules`
3. Open a terminal and execute: `lsusb`
This command will print the USB devices connected in your computer. You need to find which of them is the second keyboard.
I recommend to execute the command one time, without the second keyboard. Then, connect the second keyboard and execute the commando again.
The device that wasn't shown on the previous command is your second keyboard
4. The data shown will be like this
```
Bus 001 Device 013: ID 05a4:9759 Ortek Technology, Inc.
                       ^    ^
    This is the VendorID    And this is the ProductID
```
5. Take note of theses IDs;
6. Now, open the `/etc/udev/rules.d/70-hotkey-pad.rules` file again (as root) and paste this commands:
```
ATTRS{idVendor}=="VendorID_HERE",
ATTRS{idProduct}=="ProductID_HERE",
OWNER="name"
```
**NOTE:** Replace the `VendorID_HERE` with the VendorID data you took note before. Do the same with the `ProductID_HERE`, replacing it with the ProductID.

7. Now, execute this command in the terminal: `udevadm control --reload-rules && udevadm trigger`

<br>

## INSTALLING actkbd
**actkbd** is the software that will store and execute the macros when the specified key in the second keyboard is pressed.

Execute these commands in terminal:
```
cd ~/Downloads
git clone git@github.com:thkala/actkbd.git
cd actkbd
make
sudo make install
```

<br>

Now we need to discover which `/dev/input/event..` file is the one that controls the second keyboard.

1. In terminal, execute: `sudo evtest`
2. The *evtest* will create a numbered list with all the event files and will ask which number you would like to test.
3. Enter a number to test. You will need to discover (by trial and error) which number represents your second keyboard.
4. After inform the number, hit any key of the second keyboard. If it returns a response (like `Event: time 1566794814.921534, type 1 (EV_KEY), code 30 (KEY_A), value 0`), then take note of which number represents your second keyboard.
5. Now, in terminal, execute this command:
```
actkbd -x -s -n -d /dev/input/eventXXX
```
Replace the XXX with the number that represents your second keyboard
6. If everything is working, when you hit a key of your second keyboard, actkbd will return a keycode. Choose which keys you will use as a macro and take note of the keycodes that represents them.
7. Now, open `/etc/actkbd.conf` as root

<br>

This is the file that will be used to map the keycodes to execute commands.
The content needs to be like this:

```
# actkbd configuration file
# <keycode>:<event>:<attrs>:<command>
71:::xed
72:::xdotool key XF86AudioRaiseVolume
80:::xdotool key XF86AudioLowerVolume
```

<br>

Every line of this file needs to respect this commands separated by `:`
```
<keycode>:<event>:<attrs>:<command>
```
<br>

- **`<keycode>`**: The keycodes that represents the keys of the second keyboard. You can combine keys, for exaplme **30+48**, which means that the command will be executed when the keys A and B are pressed together.
- **`<event>`**: (Optional). Each event defines **when** the command would be executed. The possible values are:
  - **`key`**: The command will be executed when the key is pressed.
  - **`rel`**: The command will be executed when the key is released.
  - **`rep`**: The command will be executed repeatedly while the key is kept pressed.
- **`<attrs>`**: (Optional). Attributes are the default behaviors that the second keyboard will do. The most important are:
  - **`grab`**: The keyboard is locked and will execute only the defined command
  **Example**: the A key will execute the command and won't type "A".
  - **`ungrab`**: The keyboard is released and will execute the defined command and will execute its default behavior.
  **Example**: the A key will execute the command and type "A".
- **`<command>`**: Any BASH command that will be executed.

<br>

After you have configured the file with your keys, execute this, replacing the XXX with the number that represents your second keyboard.
```
actkbd -x -s -d /dev/input/eventXXX
```

<br>

## EXECUTING MACROS WITH xdotool
You can configure a combination of keys to execute only one key.

```
sudo apt install xdotool
```

As root, open the file: `/etc/actkbd.conf`

Assuming that you want the A key to perform a CTRL + SHIFT + C combination, insert the line below in the file:

```
30:key:grab:xdotool key Control+Shift+C
30:rel:ungrab:
```
