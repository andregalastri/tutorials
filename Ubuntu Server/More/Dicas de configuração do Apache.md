# DICAS DE CONFIGURAÇÃO DO APACHE

## Negando o indexamento de pastas

```apacheconf
# Habilitando rewrite
RewriteEngine On

# Negar indexação de pastas
Options -Indexes
```

## Remover a barra final da URL
Exemplo: http://www.mydomain.com/ será redirecionado para http://mydomain.com

```apacheconf
# Habilitando rewrite
RewriteEngine On

# Remover a barra no final da URL
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^(.*)/$ /$1 [L,R]
```

## Remover o "www" da URL
Exemplo: http://www.mydomain.com será redirecionado para http://mydomain.com

```apacheconf
# Habilitando rewrite
RewriteEngine On

# Remover o www da URL
RewriteCond %{HTTP_HOST} ^www\.(.+)$ [NC]
RewriteRule ^(.*)$ http://%1/$1 [R=301,L]
```

## Redirecionar subdiretórios específicos para o endereço raiz
Exemplo: http://mydomain.com/mypage será redirecionado para http://mydomain.com

```apacheconf
# Habilitando rewrite
RewriteEngine On

# Redirecionando subdiretórios específicos para o endereço raiz
RedirectMatch ^/mypage* /
```

## Redirecionar todas as requisições para o index.php
Exemplo: http://mydomain.com/mypage chamará /index.php em vez de /mypage/index.php

```apacheconf
# Habilitando rewrite
RewriteEngine On

# Redirecionar todas as requisições para index.php
RewriteCond %{HTTP_HOST} ^\. [NC]
RewriteRule ^(.*)/$ $1 [R=301,L]
RewriteRule ^(.+?)/$ / [R=404,L]
RewriteRule ^(.*)$ index.php [NC,QSA,L]
```
