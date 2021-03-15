#!/bin/sh
clear
echo "INSTALLING LAMP"
sleep 5
sudo apt update
sudo apt-get install lamp-server^
sudo apt-get install phpmyadmin
sudo a2enmod rewrite

clear
echo "CONFIGURING MYSQL"
echo "IF YOU ARE ASKED TO ENTER A PASSWORD, JUST PRESS ENTER"
sleep 5
sudo cp -rp "/var/run/mysqld" "/var/run/mysqld.bak"
sudo service mysql stop
sudo mv "/var/run/mysqld.bak" "/var/run/mysqld"
sudo mysqld_safe --skip-grant-tables --skip-networking &

mysql -p -u root -e "USE mysql; FLUSH PRIVILEGES; ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '###ROOT_PASSWORD_HERE###'; FLUSH PRIVILEGES; GRANT ALL PRIVILEGES ON *.* TO 'phpmyadmin'@'localhost' WITH GRANT OPTION; FLUSH PRIVILEGES;"

sudo service apache2 restart

clear
echo "DISABLING APACHE VIRTUAL HOSTS"
echo "TYPE 000-default WHEN ASKED"
sleep 5
sudo cp apache2.conf /etc/apache2/apache2.conf
sudo a2dissite

sudo rm /etc/apache2/sites-available/000-default.conf
sudo rm /etc/apache2/sites-available/default-ssl.conf

sudo cp phpmyadmin.conf /etc/apache2/sites-available/phpmyadmin.conf

clear
echo "CONFIGURING MULTIPLE PHP VERSIONS"
echo "Will install PHP 8.0 AND 7.4"
sleep 5
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

sudo a2ensite

sudo service apache2 restart

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
