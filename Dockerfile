FROM php:5.6-apache
MAINTAINER Christian Simon <simon@illucit.com>

# install the PHP extensions we need
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y libcurl4-gnutls-dev libpng-dev libssl-dev libc-client2007e-dev libkrb5-dev unzip cron re2c python tree libjpeg-dev libpng-dev wget \
  && docker-php-ext-configure imap --with-imap-ssl --with-kerberos \
  && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
  && docker-php-ext-install mysqli curl gd zip mbstring imap iconv \
  && rm -rf /var/lib/apt/lists/* \
  && echo 'register_globals = Off' > /usr/local/etc/php/conf.d/squirrelmail.ini \
  && echo 'magic_quotes_runtime = Off' >> /usr/local/etc/php/conf.d/squirrelmail.ini \
  && echo 'magic_quotes_gpc = Off' >> /usr/local/etc/php/conf.d/squirrelmail.ini \
  && echo 'file_upload = On' >> /usr/local/etc/php/conf.d/squirrelmail.ini \
  && echo 'error_reporting = E_ERROR' >> /usr/local/etc/php/conf.d/squirrelmail.ini