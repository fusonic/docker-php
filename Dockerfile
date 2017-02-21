FROM php:7.0

MAINTAINER Fusonic "office@fusonic.net"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git curl bzip2 mysql-client \
                       libxslt1.1 libmcrypt4 libcurl3 libenchant1c2a libgmp10 libc-client2007e libkrb5-3 \
                       libfbclient2 firebird2.5-common libldap-2.4-2 gcc make libxml2-dev libssl-dev libbz2-dev \
                       libmcrypt-dev libreadline6-dev libxslt1-dev libcurl4-openssl-dev libenchant-dev libpng12-dev \
                       libgmp3-dev libc-client2007e-dev libkrb5-dev firebird-dev libldap2-dev libmemcached-dev && \
    ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h && \
    ln -s /usr/lib/libc-client.a /usr/lib/x86_64-linux-gnu/libc-client.a && \
    docker-php-ext-install -j$(nproc) mysqli gd zip && \
    pecl install memcached-3.0.3 && \
    docker-php-ext-enable memcached && \
    curl -L https://getcomposer.org/composer.phar > /usr/bin/composer && chmod +x /usr/bin/composer && \
    curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get install nodejs && \
    curl https://www.npmjs.com/install.sh | sh && \
    apt-get autoremove -y && \
    docker-php-source delete && \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /usr/share/man
