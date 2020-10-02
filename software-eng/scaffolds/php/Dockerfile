FROM php:7.4-cli

LABEL maintainer="Trocafone Tech tech@trocafone.com"

WORKDIR /opt/interview-challenge

RUN apt-get update && \
    apt-get install -y zip unzip libzip-dev && \
    docker-php-ext-install -j$(nproc) zip


RUN php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" && \
    php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

COPY . ./

RUN composer install && \
    composer dump-autoload

ENTRYPOINT ["/opt/interview-challenge/entrypoint.sh"]
CMD ["test"]
