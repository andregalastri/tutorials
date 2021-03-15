# ABOUT PHP-FPM
When using PHP-FPM, every change in PHP settings need to be made in the `php.ini` that is inside `fpm` folder.

<br>

## COMMON php.ini LOCATIONS OF PHP-FPM

```
/etc/php/7.4/fpm/php.ini
/etc/php/8.0/fpm/php.ini
```
<br>

## RESTARTING PHP-FPM SERVICE
You need to specify which version you want to reload 

```bash
/etc/init.d/php7.4-fpm restart
/etc/init.d/php8.0-fpm restart
```
