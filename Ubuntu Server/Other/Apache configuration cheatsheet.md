# APACHE CONFIGURATION CHEATSHEET

## Denying folder indexing

```apacheconf
# Enabling rewrite
RewriteEngine On

# Deny folder indexing
Options -Indexes
```

## Removing the slashbar from the end of the URL
Example: http://www.mydomain.com/ will be redirected to http://mydomain.com

```apacheconf
# Enabling rewrite
RewriteEngine On

# Remove slash bar at the end of the URL
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^(.*)/$ /$1 [L,R]
```

## Removing the www from URL
Example: http://www.mydomain.com will be redirected to http://mydomain.com

```apacheconf
# Enabling rewrite
RewriteEngine On

# Remove the www from URL
RewriteCond %{HTTP_HOST} ^www\.(.+)$ [NC]
RewriteRule ^(.*)$ http://%1/$1 [R=301,L]
```

## Redirecting specific subdirectories to root address
Example: http://mydomain.com/mypage will be redirected to http://mydomain.com

```apacheconf
# Enabling rewrite
RewriteEngine On

# Redirecting specific subdirectories to root address
RedirectMatch ^/mypage* /
```

## Redirect all requests to index.php
Example: http://mydomain.com/mypage will call `/index.php` instead of `/mypage/index.php`

```apacheconf
# Enabling rewrite
RewriteEngine On

# Redirect all requests to index.php
RewriteCond %{HTTP_HOST} ^\. [NC]
RewriteRule ^(.*)/$ $1 [R=301,L]
RewriteRule ^(.+?)/$ / [R=404,L]
RewriteRule ^(.*)$ index.php [NC,QSA,L]
```
