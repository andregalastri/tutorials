# INSTALLING FTP SERVER

## Installation and configuration:
Execute the following commands:

```bash
sudo apt update
sudo apt install vsftpd
```

Open the configuration file of **Vsftpd**:

```bash
sudo nano /etc/vsftpd.conf
```

Find the `anonymous_enable` parameter and set it to `NO`.

```conf
# Allow anonymous FTP? (Disabled by default).
anonymous_enable=NO
```

Find the `local_enable` parameter and uncomment it. Be shure that its value is set to `YES`.

```conf
# Uncomment this to allow local users to log in.
local_enable=YES
```

Find the `chroot_local_user` parameter and uncomment it. Be shure that its value is set to `YES`.

```conf
# You may restrict local users to their home directories.  See the FAQ for
# the possible risks in this before using chroot_local_user or
# chroot_list_enable below.
chroot_local_user=YES
```

Find the `write_enable` parameter and uncomment it. Be shure that its value is set to `YES`.

```conf
# Uncomment this to enable any form of FTP write command.
write_enable=YES
```

At the bottom of the file, add these parameters.

**NOTE**: In the parameter `pasv_address` inform the public IP address of your server.

```conf
pasv_enable=YES
pasv_address=<Public IP of your server>
pasv_min_port=12000
pasv_max_port=12100
port_enable=YES
force_dot_files=YES
allow_writeable_chroot=YES
user_sub_token=$USER
local_root=/home/$USER/userfolder
```

Save the file pressing `Ctrl + s` and then `Ctrl + x` to exit.

## Configuring FTP users

Create a new user group to the FTP users. Name it whatever you like. In this example I will use the name `ftpgroup`.

```bash
sudo groupadd ftpgroup
```

Create a new user and add it to the group created. Name the user whatever you like. In this example I will use the name `ftpuser`

```bash
useradd -g ftpgroup ftpuser
```

Define a password to this user:

```bash
passwd ftpuser
```

It is **NEEDED** to create a folder with the same name of the user created above inside the `/home`folder.
We will make the user to have access only to this folder. Execute the following commands:

**NOTE:** always replace the `ftpuser` username to the one that you created.

```bash
cd /home
sudo mkdir ftpuser
sudo choun ftpuser:ftpgroup ftpuser
sudo chmod a-w ftpuser
sudo mkdir /home/ftpuser/public
sudo chown ftpuser:ftpgroup /home/ftpuser/userfolder

sudo service vsftpd restart
```

**NOTE**: The `userfolder` will be the root of the user automatically. He won't be able to access folders outside it.
You can change the name of this folder, but you will need to change the `local_root` parameter in the `/etc/vsftpd.conf` to the name you choose.
This public folder name NEEDS to be the same to all users.

## Connecting

* **Host:** The IP of your server or the domain
* **Port:** 21 of leave it in blank
* **Cryptography**: Simple
* **Logon Type:** Normal
* **Username:** The username you created
* **Password:** The password you gave to this username

<br><br>
<div>
    <table width="9000">
        <tr>
            <td width="9000">
                <a href="https://github.com/andregalastri/tutorials/blob/main/Ubuntu%20Server/7.%20Using%20Tmux%20and%20Ranger%20for%20better%20server%20management.md">
                    <b>7. Using Tmux and Ranger for better server management</b>
                </a>
            </td>
            <td width="50%" align="right">
                <a href="">
                    <b></b>
                </a>
            </td>
        </tr>
        <tr>
            <td width="9000" colspan="2" align="center">
                <a href="">
                    <b>Return to the main list</b>
                </a>
            </td>
        </tr>
    </table>
</div>
