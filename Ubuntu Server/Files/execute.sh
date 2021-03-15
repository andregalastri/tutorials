#!/bin/sh

sudo apt-get install lamp-server^
sudo apt-get install phpmyadmin
sudo a2enmod rewrite

sudo cp -rp "/var/run/mysqld" "/var/run/mysqld.bak"
sudo service mysql stop
sudo mv "/var/run/mysqld.bak" "/var/run/mysqld"
sudo mysqld_safe --skip-grant-tables --skip-networking &

mysql -p -u root -e "USE mysql; FLUSH PRIVILEGES; ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '###ROOT_PASSWORD_HERE###'; FLUSH PRIVILEGES; GRANT ALL PRIVILEGES ON *.* TO 'phpmyadmin'@'localhost' WITH GRANT OPTION; FLUSH PRIVILEGES;"

sudo service apache2 restart

sudo cp apache2.conf /etc/apache2/apache2.conf
sudo a2dissite

sudo rm /etc/apache2/sites-available/000-default.conf
sudo rm /etc/apache2/sites-available/default-ssl.conf

sudo cp phpmyadmin.conf /etc/apache2/sites-available/phpmyadmin.conf

sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update

sudo apt install php8.0 php8.0-fpm
sudo apt install php8.0-mysql php8.0-mbstring php8.0-xml php8.0-gd php8.0-curl

sudo apt install php7.4 php7.4-fpm 
sudo apt install php7.4-mysql php7.4-mbstring php7.4-xml php7.4-gd php7.4-curl

sudo a2dismod php7.4
sudo a2dismod mpm_prefork
sudo a2enmod mpm_event proxy_fcgi setenvif

sudo a2ensite

sudo service apache2 restart
