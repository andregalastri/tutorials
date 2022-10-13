#!/bin/bash
message(){
 i=$1
 while [ $i -gt -1 ]
 do
  clear
  echo -e $2
  echo ''
  echo $i && sleep 1
  i=$(( $i - 1 ))
 done
}

message 7 "INSTALLING LAMP \nWhen PHPMyAdmin asks 'apache2' or 'lighttpd', choose 'apache2' \nAlso, allow to configure phpmyadmin user when asked"
sudo apt update
sudo apt-get install lamp-server^
sudo apt-get install phpmyadmin
sudo a2enmod rewrite

message 5 "CONFIGURING MYSQL\nIf you are asked to enter a password, just hit enter"
sudo cp -rp "/var/run/mysqld" "/var/run/mysqld.bak"
sudo service mysql stop
sudo mv "/var/run/mysqld.bak" "/var/run/mysqld"
sudo mysqld_safe --skip-grant-tables --skip-networking &

mysql -p -u root -e "USE mysql; FLUSH PRIVILEGES; ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '###ROOT_PASSWORD_HERE###'; FLUSH PRIVILEGES; GRANT ALL PRIVILEGES ON *.* TO 'phpmyadmin'@'localhost' WITH GRANT OPTION; FLUSH PRIVILEGES;"

sudo service apache2 restart

message 5 "DISABLING APACHE VIRTUAL HOSTS"
sudo cp apache2.conf /etc/apache2/apache2.conf
sudo a2dissite 000-default

sudo rm /etc/apache2/sites-available/000-default.conf
sudo rm /etc/apache2/sites-available/default-ssl.conf

sudo cp phpmyadmin.conf /etc/apache2/sites-available/phpmyadmin.conf

message 5 "CONFIGURING MULTIPLE PHP VERSIONS \nWill install PHP 8.0 AND 7.4"
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update

sudo apt install php8.0 php8.0-fpm
sudo apt install php8.0-mysql php8.0-mbstring php8.0-xml php8.0-gd php8.0-curl php8.0-sqlite3

sudo apt install php7.4 php7.4-fpm 
sudo apt install php7.4-mysql php7.4-mbstring php7.4-xml php7.4-gd php7.4-curl php7.4-sqlite3

sudo a2dismod php7.4
sudo a2dismod mpm_prefork
sudo a2enmod mpm_event proxy_fcgi setenvif

sudo service apache2 restart

message 5 "INSTALLING AUTOMYSQLBACKUP"
sudo apt-get install automysqlbackup

message 5 "INSTALLING COMPOSER"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
HASH="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
sudo rm composer-setup.php

clear
echo "DONE!"
echo "- Now, configure PHPMyAdmin virtual host in: "
echo ""
echo "   /etc/apache2/sites-available/phpmyadmin.conf"
echo ""
echo "- After that, execute the following command to enable phpmyadmin virtual host:"
echo ""
echo "   sudo a2ensite"
echo ""
echo "- Finally, restart Apache with:"
echo ""
echo "   sudo service apache2 restart"
echo ""
echo "------"
echo "See ya!"
echo ""
echo ""
