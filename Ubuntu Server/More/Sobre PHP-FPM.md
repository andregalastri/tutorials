# SOBRE O PHP-FPM
Quando usar o **PHP-FPM**, todas as alterações nas configurações do PHP precisam ser feitas no `php.ini` que está dentro da pasta `fpm`.

<br>

## LOCALIZAÇÕES COMUNS DO php.ini DO PHP-FPM

```
/etc/php/7.4/fpm/php.ini
/etc/php/8.0/fpm/php.ini
```
<br>

## REINICIANDO O SERVIÇO PHP-FPM
Você precisa especificar qual versão deseja recarregar:

```bash
/etc/init.d/php7.4-fpm restart
/etc/init.d/php8.0-fpm restart
```
