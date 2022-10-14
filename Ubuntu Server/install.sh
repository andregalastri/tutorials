#!/bin/bash

##
# 1. Installing Apache
##
sudo apt update -y; sudo apt upgrade -y;
sudo apt install apache2 -y;
sudo a2enmod rewrite;
sudo a2dissite 000-default;
sudo rm -rf /etc/apache2/sites-available/000-default.conf;
sudo rm -rf /etc/apache2/sites-available/default-ssl.conf;
sudo usermod -a -G $USER www-data;
sudo apt install software-properties-common -y;
sudo add-apt-repository ppa:ondrej/php -y;
sudo apt update;

##
# 2. Configuring PHP Multiple Versions copy
##
sudo apt install php8.1 php8.1-fpm libapache2-mod-php8.1 php8.1-common php8.1-mysql php8.1-xmlrpc php8.1-curl php8.1-gd php8.1-imagick php8.1-cli php8.1-imap php8.1-mbstring php8.1-opcache php8.1-soap php8.1-zip php8.1-intl php8.1-bcmath php8.1-sqlite3 -y;

sudo apt install php8.0 php8.0-fpm libapache2-mod-php8.0 php8.0-common php8.0-mysql php8.0-xmlrpc php8.0-curl php8.0-gd php8.0-imagick php8.0-cli php8.0-imap php8.0-mbstring php8.0-opcache php8.0-soap php8.0-zip php8.0-intl php8.0-bcmath php8.0-sqlite3 -y;

sudo apt install php7.4 php7.4-fpm libapache2-mod-php7.4 php7.4-common php7.4-mysql php7.4-xmlrpc php7.4-curl php7.4-gd php7.4-imagick php7.4-cli php7.4-imap php7.4-mbstring php7.4-opcache php7.4-soap php7.4-zip php7.4-intl php7.4-bcmath php7.4-sqlite3 -y;

sudo a2dismod php8.1 php8.0 php7.4 mpm_prefork;
sudo a2enmod mpm_event proxy_fcgi setenvif;

sudo systemctl enable php8.1-fpm;
sudo systemctl enable php8.0-fpm;
sudo systemctl enable php7.4-fpm;

sudo service php8.1-fpm start;
sudo service php8.0-fpm start;
sudo service php7.4-fpm start;

##
# 3. Enabling Let's Encrypt SSL
##
sudo apt install certbot python3-certbot-apache;

##
# 4. Installing Composer
##
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');";
HASH="$(wget -q -O - https://composer.github.io/installer.sig)";
php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;";
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer;
sudo rm composer-setup.php;

##
# Final messages
##
echo "You need to configure the Apache's virtual hosts manually.";
echo "After everything working (and your website able to be accessed), you need to run 'sudo certbot --apache' to enable Let's Encrypt SSL.";