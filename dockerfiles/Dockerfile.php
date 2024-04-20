# FROM php:8.3.6-fpm-bookworm AS BASE
FROM php:8.3.6-fpm-alpine AS BASE

ARG PHPGROUP=laravel
ARG PHPUSER=laravel

# RUN addgroup -g ${GID} --system laravel
# RUN adduser -G laravel --system -D -s /bin/sh -u ${UID} laravel
RUN adduser -g ${PHPGROUP} -s /bin/sh -D ${PHPUSER}

RUN sed -i "s/user = www-data/user = ${PHPUSER}/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = ${PHPGROUP}/g" /usr/local/etc/php-fpm.d/www.conf

WORKDIR /var/www/html/

RUN apk add libzip-dev 

RUN curl -sSL https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions -o - | sh -s intl sodium
RUN docker-php-ext-install pdo pdo_mysql zip bz2

# -R allows PHP to run as root
USER ${PHPUSER}

CMD ["php-fpm", "-c", "/usr/local/etc/php-fpm.conf", "-R"]