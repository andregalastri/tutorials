#!/bin/bash

sudo apt update; sudo apt upgrade;
sudo apt install apache2;
sudo a2enmod rewrite;

sudo a2dissite 000-default;

sudo rm -rf /etc/apache2/sites-available/000-default.conf;
sudo rm -rf /etc/apache2/sites-available/default-ssl.conf;

sudo usermod -a -G $USER www-data;

sudo apt install software-properties-common;
sudo add-apt-repository ppa:ondrej/php;
sudo apt update;

sudo apt install php8.1 php8.1-fpm libapache2-mod-php8.1 php8.1-common php8.1-mysql php8.1-xmlrpc php8.1-curl php8.1-gd php8.1-imagick php8.1-cli php8.1-imap php8.1-mbstring php8.1-opcache php8.1-soap php8.1-zip php8.1-intl php8.1-bcmath php8.1-sqlite3;

sudo apt install php8.0 php8.0-fpm libapache2-mod-php8.0 php8.0-common php8.0-mysql php8.0-xmlrpc php8.0-curl php8.0-gd php8.0-imagick php8.0-cli php8.0-imap php8.0-mbstring php8.0-opcache php8.0-soap php8.0-zip php8.0-intl php8.0-bcmath php8.0-sqlite3;

sudo apt install php7.4 php7.4-fpm libapache2-mod-php7.4 php7.4-common php7.4-mysql php7.4-xmlrpc php7.4-curl php7.4-gd php7.4-imagick php7.4-cli php7.4-imap php7.4-mbstring php7.4-opcache php7.4-soap php7.4-zip php7.4-intl php7.4-bcmath php7.4-sqlite3;

sudo a2dismod php8.1 php8.0 php7.4 mpm_prefork;
sudo a2enmod mpm_event proxy_fcgi setenvif;

sudo systemctl enable php8.1-fpm;
sudo systemctl enable php8.0-fpm;
sudo systemctl enable php7.4-fpm;

sudo service php8.1-fpm start;
sudo service php8.0-fpm start;
sudo service php7.4-fpm start;

sudo apt install mysql-server;
sudo systemctl enable mysql.service;
sudo systemctl start mysql.service;

sudo apt-get install phpmyadmin;

sudo rm -rf /usr/share/phpmyadmin.bak;
sudo mv /usr/share/phpmyadmin/ /usr/share/phpmyadmin.bak;
sudo mkdir /usr/share/phpmyadmin/;
cd /usr/share/phpmyadmin/;
sudo wget https://files.phpmyadmin.net/phpMyAdmin/5.2.0/phpMyAdmin-5.2.0-all-languages.tar.gz;
sudo tar xzf phpMyAdmin-5.2.0-all-languages.tar.gz;
sudo mv phpMyAdmin-5.2.0-all-languages/* /usr/share/phpmyadmin;

blowfishSecret=$(curl -X POST -d 'pw=32' -d 'uc=1' -d 'lc: 1' -d 'nu: 1' -d 'sy: 1' -d 's: 0' -d 'a: 1' 'https://passgen.co/gen.php');

echo "
<?php
   // use here a value of your choice 32 chars long
   $cfg['blowfish_secret'] = '$blowfishSecret';

   $i=0;
   $i++;
   $cfg['Servers'][$i]['auth_type']     = 'cookie';
" | sudo tee -a /usr/share/phpmyadmin/config.inc.php;

sudo mkdir /usr/share/phpmyadmin/tmp;
sudo chmod 777 /usr/share/phpmyadmin/tmp;

sudo rm /usr/share/phpmyadmin/phpMyAdmin-5.2.0-all-languages.tar.gz;
sudo rm -rf /usr/share/phpmyadmin/phpMyAdmin-5.2.0-all-languages;
sudo rm -rf /usr/share/phpmyadmin.bak;
cd $HOME;

sudo cp -rp "/var/run/mysqld" "/var/run/mysqld.bak";
sudo service mysql stop;
sudo mv "/var/run/mysqld.bak" "/var/run/mysqld";
sudo mysqld_safe --skip-grant-tables --skip-networking;

echo "Create a password for MySQL root user:\n"
read $rootPassword;
mysql -p -u root -e "USE mysql; FLUSH PRIVILEGES; ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$rootPassword'; FLUSH PRIVILEGES; GRANT ALL PRIVILEGES ON *.* TO 'phpmyadmin'@'localhost' WITH GRANT OPTION; FLUSH PRIVILEGES;";

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');";
HASH="$(wget -q -O - https://composer.github.io/installer.sig)";
php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;";
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer;
sudo rm composer-setup.php;