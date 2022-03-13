# INSTALLING GITEA (SELF-HOSTED GITHUB-LIKE APP)
Installing and configuring Gitea.

## DOWNLOAD
* Execute the following command
  
  ```bash
  wget -O gitea https://dl.gitea.io/gitea/1.16.3/gitea-1.16.3-linux-amd64
  chmod +x gitea
  ```

<br>

## INSTALLING
1. We will use the binary as a service in Linux. First, we need to add a new user and a group called `gitea`.

   ```bash
   sudo adduser \
     --system \
     --shell /bin/bash \
     --gecos 'Git Version Control' \
     --group \
     --disabled-password \
     --home /home/gitea \
     gitea
   ```

2. Create the following directories

   ```bash
   sudo mkdir -p /var/lib/gitea/{custom,data,log}
   sudo chown -R gitea:gitea /var/lib/gitea/
   sudo chmod -R 750 /var/lib/gitea/
   sudo mkdir /etc/gitea
   sudo chown root:gitea /etc/gitea
   sudo chmod 770 /etc/gitea
   ```
   
3. Move the `gitea` binary to the proper folder

   ```bash
   sudo cp gitea /usr/local/bin/gitea
   ```

### Creating a service to run Gitea

1. We need to create a service file. Execute the following command:

   ```bash
   sudo nano /etc/systemd/system/gitea.service
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
 sudo systemctl enable gitea
 sudo systemctl start gitea
 ```

<br>

## CONFIGURING IT TO RUN IN A SERVER ENVIRONMENT

### Running in an IP based URL

Gitea is configured to run in http://localhost:3000 by default. This means that if you are running Gitea in your local machine, it will work fine, but what if you are running it in a server, accessing it by an IP, like http://192.168.0.100:3000?

To configure it, we need to open the `app.ini`, which is the configuration file of Gitea.

1. Run the followin command:

   ```bash
   sudo nano /etc/gitea/app.ini
   ```

2. If it asks if you want to edit the file using ROOT, choose **Yes**
3. Find this part of the code:
   
   ```ini
   ROOT_URL         = http://localhost:3000/
   ```

4. Replace it to the IP of your server, as the following example:

   ```ini
   ROOT_URL         = http://192.168.0.100:3000/
   ```

5. Press **`CTRL + S`** to save and **`CTRL + X`** to close Nano.
6. Restart the Gitea service

   ```bash
   sudo systemctl restart gitea
   ```

### Running in a domain based URL with Apache's Vhosts Proxys

Gitea is configured to run in http://localhost:3000 by default. This means that if you are running Gitea in your local machine, it will work fine, but what if you are running it in a server, accessing it by a domain, like http://git.mydomain.com?

To configure it, we need to open the `app.ini`, which is the configuration file of Gitea.

1. Run the following command:

   ```bash
   sudo nano /etc/gitea/app.ini
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
   sudo systemctl restart gitea
   ```
<br>

**Creating a Vhost to redirect access to the domain**

1. Enable the proxy modules from Apache

   ```bash
   sudo a2enmod proxy
   sudo a2enmod proxy_http
   ```
   
3. Run the following command

   ```bash
   sudo nano /etc/apache2/sives-available/gitea.conf
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
   sudo a2ensite gitea
   sudo service apache2 restart
   ```

1. Open your `hosts` file

   ```bash
   sudo nano /etc/hosts
   ```

1. Open your `hosts` file

   ```hosts
   127.0.0.1    your_gitea_domain.com
   ```
   <br>
   
   > **IMPORTANT**: Change the `your_gitea_domain.com` part to the domain of yours.

<br>

# FIRST RUN

1. Access your http://localhost:3000/ or [http://your_ip_here:3000/](http://your_ip_here:3000/) or http://your_gitea_domain.com







**Notes:**

 - When installing `phpmyadmin`, it will ask to select which server would be used. Select **apache2**.
 - `phpmyadmin` installation will ask if you want to configure the *phpmyadmin* user. Select **yes** and type a password of your choice.

<br>

## CONFIGURING
We need to define a MySQL *root* user password and give root permissions (with granted) to *phpmyadmin* user.
Execute the following commands:

    sudo cp -rp "/var/run/mysqld" "/var/run/mysqld.bak"
    sudo service mysql stop
    sudo mv "/var/run/mysqld.bak" "/var/run/mysqld"
    sudo mysqld_safe --skip-grant-tables --skip-networking &

Next we need to add a password to the root user and give root permission to the phpmyadmin user.

<br>

> **ATTENTION!**
> BEFORE EXECUTE TO FOLLOWING COMMAND, EDIT IT CHANGING THE `###ROOT_PASSWORD_HERE###` ENTERING A PROPER AND STRONG PASSWORD!
> 
> **NOTE:** If MySQL asks for a password, just hit ENTER.

    mysql -p -u root -e "USE mysql; FLUSH PRIVILEGES; ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '###ROOT_PASSWORD_HERE###'; FLUSH PRIVILEGES; GRANT ALL PRIVILEGES ON *.* TO 'phpmyadmin'@'localhost' WITH GRANT OPTION; FLUSH PRIVILEGES;"

<br>

After there commands, it is a good idea to reboot the VPS

    sudo reboot

<br><br>
<div>
    <table width="9000">
        <tr>
            <td width="9000">
            </td>
            <td width="50%" align="right">
                <a href="https://github.com/andregalastri/tutorials/blob/main/Ubuntu%20Server/2.%20Configuring%20Apache%20Domains-Subdomains.md"><b>2. Configuring Apache Domains/Subdomains</b></a>
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
