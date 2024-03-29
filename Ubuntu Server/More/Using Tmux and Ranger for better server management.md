# USING TMUX AND RANGER FOR BETTER SERVER MANAGEMENT

Ranger is a terminal file manager and Tmux allows you to open multiple windows in the same SSH connection.

<br>

Access the server and install Ranger and Tmux (if it isn't installed):
```bash
sudo apt install ranger tmux
```

<br>

## Install tmux-ressurect plugin for Tmux
1. Clone `tmux-ressurect` plugin from Github using the command below:
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
2. Open/Create the file `tmux.conf` in your home folder:
```bash
nano ~/.tmux.conf
```
3. Paste the following code in the file:
```conf
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'

set -g @continuum-restore 'on'
set -g @resurrect-processes ':all:'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
```
**MUCH IMPORTANT NOTE**: The `set -g @resurrect-processes ':all:'` saves the Tmux all the opened programs in it when it performs a session storing. It can be dangerous if you use programs that uses some kind of context and leave it opened.
Read more about it [here](https://github.com/tmux-plugins/tmux-resurrect/blob/master/docs/restoring_programs.md). If you prefer, disable it by placing a `#` in front of this line.

4. Open Tmux by executing the command `tmux`
5. Execute `tmux source ~/.tmux.conf`
6. Press `Ctrl + b` and then `Shift + i`. A message will show up saying that it was reloaded.
   ![image](https://user-images.githubusercontent.com/49572917/129652334-e10fefb6-3948-4ab6-8996-969af3b9f75d.png)
   
7. Use Tmux normally, the sessions will be saved automatically every 15 minutes.
   * To save the session manually press `Ctrl + b` and then `Ctrl + s`.
   * To restore the session (after you reboot the server, for example), open Tmux again and press `Ctrl + b` and then `Ctrl + r`.

<br><br>

## Connecting to SSH and automatically run `tmux`
When you connect to a SSH, use the following command to run `tmux` automatically attached to session zero.<br>
If there is no tmux session active, it will just create a new one.

> **IMPORTANT: Change the `your_ip_or_domain_address` part to your server SSH IP or domain address.**<br>
> **If your user is not `ubuntu`, change it as well.**


```bash
ssh ubuntu@your_ip_or_domain_address -t "tmux attach -t 0 || tmux"
```

<br><br>
<div>
    <table width="9000">
        <tr>
            <td width="9000">
                <a href="https://github.com/andregalastri/tutorials/blob/main/Ubuntu%20Server/6.%20Installing%20Composer.md">
                  <b>6. Installing Composer</b>
              </a>
            </td>
            <td width="50%" align="right">
                <a href="https://github.com/andregalastri/tutorials/blob/main/Ubuntu%20Server/8.%20Installing%20and%20configuring%20a%20FTP%20server.md">
                   <b>8. Installing and configuring a FTP server</b>
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
