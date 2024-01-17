FROM php:8.2-apache

# PHP拡張機能のインストール
RUN apt-get update && apt-get install -y \
        libzip-dev \
        zip \
        libpng-dev \
        && docker-php-ext-install zip pdo_mysql gd

# Apache設定
COPY ./docker/apache/vhost.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite headers

# Composerのインストール
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# アプリケーションファイルのコピー
COPY . /var/www/html

# アプリケーションディレクトリの設定
WORKDIR /var/www/html

# Portの公開
EXPOSE 80
