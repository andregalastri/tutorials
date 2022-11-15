# INSTALLING GITEA (SELF-HOSTED GITHUB-LIKE APP)
Installing and configuring Gitea.

## DOWNLOAD
* Execute the following commands
  
  ```bash
  wget -O gitea https://dl.gitea.io/gitea/1.17.3/gitea-1.17.3-linux-amd64;
  chmod +x gitea;
  ```

<br>

## INSTALLING
1. We will use the binary as a service in Linux. First, we need to add a new user and a group called `gitea`. The current user will be part of this group as well

   ```bash
   sudo adduser \
     --system \
     --shell /bin/bash \
     --gecos 'Git Version Control' \
     --group \
     --disabled-password \
     --home /home/gitea \
     gitea;

   sudo usermod -aG gitea $USER;
   ```

2. Create the following directories

   ```bash
   sudo mkdir -p /var/lib/gitea/{custom,data,log};
   sudo chown -R gitea:gitea /var/lib/gitea/;
   sudo chmod -R 750 /var/lib/gitea/;
   sudo mkdir /etc/gitea;
   sudo chown root:gitea /etc/gitea;
   sudo chmod 770 /etc/gitea;
   ```
   
3. Move the `gitea` binary to the proper folder

   ```bash
   sudo mv gitea /usr/local/bin/gitea;
   ```

### Creating a service to run Gitea

1. We need to create a service file. Execute the following command:

   ```bash
   sudo nano /etc/systemd/system/gitea.service;
   ```

2. Nano Editor will be opened to create our `gitea.server` file. Paste the following content into the editor

   ```ini
   [Unit]
   Description=Gitea (Git with a cup of tea)
   After=syslog.target
   After=network.target

   [Service]
   RestartSec=2s
   Type=simple
   User=gitea
   Group=gitea
   WorkingDirectory=/var/lib/gitea/
   ExecStart=/usr/local/bin/gitea web --config /etc/gitea/app.ini
   Restart=always
   Environment=USER=gitea HOME=/home/gitea GITEA_WORK_DIR=/var/lib/gitea

   [Install]
   WantedBy=multi-user.target
   ```

 3. Press **`CTRL + S`** to save and **`CTRL + X`** to close Nano.
 4. Run the Gitea as a service
 
    ```bash
    sudo systemctl enable gitea;
    sudo systemctl start gitea;
    ```

<br>

## FIRST RUN

1. Open your browser and access your localhost http://localhost:3000 or your server http://your_server_ip:3000
1. In database settings:<br>
   ![image](https://user-images.githubusercontent.com/49572917/158070145-47a6f073-d479-4bbd-9b81-c1715be9fb32.png)
   
   * I prefer to use SQLite as database because it is easier for backup
   * Leave the default database path.
   
1. In general settings:<br>
   ![image](https://user-images.githubusercontent.com/49572917/158070177-285b5b7d-bfc0-45b6-8a95-cf51715fb36a.png)
   * You can change the server name to a one that pleases you. You can leave it with the default value as well.
   * Leave the repository path, LFS root, username, server domain, SSH port with its default values.
   * If you are running Gitea on your localhost, leave it that way. However, if you are running it in a server and accessing it by an IP, change the http://localhost:3000 to http://your_server_ip:3000.
   * Leave the log path with its default value.
   
1. Press **Install Gitea** button and you are done!

<br>

# RUNNING IN A DOMAIN BASED URL USING APACHE'S VHOST PROXYS
What if you want to access Gitea entering a domain or subdomain URL, like http://git.mydomain.com?

We need to open the `app.ini`, which is the configuration file of Gitea.

1. Run the following command:

   ```bash
   sudo nano /etc/gitea/app.ini;
   ```

2. If it asks if you want to edit the file using ROOT, choose **Yes**
3. Find this part of the code:
   
   ```ini
   ROOT_URL         = http://localhost:3000/
   ```

4. Replace it to your domain, as the following example:

   ```ini
   ROOT_URL         = http://your_gitea_domain.com/
   ```

5. Press **`CTRL + S`** to save and **`CTRL + X`** to close Nano.
6. Restart the Gitea service

   ```bash
   sudo systemctl restart gitea;
   ```
<br>

### Creating a Vhost to redirect access to the domain

1. Enable the proxy modules from Apache

   ```bash
   sudo a2enmod proxy;
   sudo a2enmod proxy_http;
   ```
   
3. Run the following command

   ```bash
   sudo nano /etc/apache2/sites-available/gitea.conf;
   ```

1. Copy and paste the content below

   ```conf
   <VirtualHost *:80>
        ServerName your_gitea_domain.com
        ServerAlias your_gitea_domain.com
        ProxyPreserveHost On
        ProxyRequests off
        ProxyPass / http://localhost:3000/
        ProxyPassReverse / http://localhost:3000/
   </VirtualHost>
   ```
   <br>
   
   > **IMPORTANT**: Change the `your_gitea_domain.com` part to the domain of yours.

1. Press **`CTRL + S`** to save and **`CTRL + X`** to close Nano.
1. Run the following commands

   ```bash
   sudo a2ensite gitea;
   sudo service apache2 restart;
   ```

### Adding the domain or subdomain in the `hosts` file

1. Open your `hosts` file

   ```bash
   sudo nano /etc/hosts;
   ```

1. Open your `hosts` file

   ```hosts
   127.0.0.1    your_gitea_domain.com
   ```
   <br>
   
   > **IMPORTANT**: Change the `your_gitea_domain.com` part to the domain of yours.

<br>

# MIGRATING TO ANOTHER SERVER
**IMPORTANT:**\
This will only work between Giteas that share the same version.

<br>

### Backup your current Gitea installation
**Before proceed, make sure no one is using Gitea because we will stop the service.**

1. Run the following commands:
  ```bash
  sudo systemctl stop gitea;
  sudo mkdir -p $HOME/gitea/var/lib/gitea;
  sudo mkdir -p $HOME/gitea/etc/gitea;
  sudo cp -R /var/lib/gitea/* $HOME/gitea/var/lib/gitea/;
  sudo cp -R /etc/gitea/* $HOME/gitea/etc/gitea/;
  cd $HOME/;
  sudo tar -czf $HOME/gitea-backup.tar.gz gitea;
  sudo rm -R gitea;
  ```
1. Move the `gitea-backup.tar.gz` file to the new server.

<br>

### Restore your current Gitea installation in the new server
1. At the new server, place the `gitea-backup.tar.gz` in the home folder of your user.
1. Run the following commands:
  ```bash
  sudo systemctl stop gitea;
  
  cd $HOME;
  sudo tar -xf gitea-backup.tar.gz;
  
  sudo mv /var/lib/gitea /var/lib/gitea_OLD;
  sudo mv /etc/gitea /etc/gitea_OLD;
  
  sudo cp -R $HOME/gitea/var/lib/gitea/ /var/lib/gitea/;
  sudo cp -R $HOME/gitea/etc/gitea/ /etc/gitea/;
  
  sudo chown -R gitea:gitea /var/lib/gitea/;
  sudo chmod -R 770 /var/lib/gitea/;
  sudo chown root:gitea /etc/gitea;
  sudo chmod 770 /etc/gitea;
  
  sudo systemctl start gitea;
  ```

Test if everything is working. If so, you can run the following commands to remove unnecessary folders:

```bash
sudo rm -R $HOME/gitea/;
sudo rm -R /var/lib/gitea_OLD/;
sudo rm -R /etc/gitea_OLD/;
```
