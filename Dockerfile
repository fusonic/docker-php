FROM php:8.0

MAINTAINER Fusonic "office@fusonic.net"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y gnupg && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    curl -sS https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    echo "deb http://dl.yarnpkg.com/debian/ stable main">/etc/apt/sources.list.d/yarn.list && \
    apt-get install -y git git-lfs curl bzip2 default-mysql-client \
                       libxslt1.1 libmcrypt4 libcurl4 libenchant1c2a libgmp10 libc-client2007e libkrb5-3 \
                       libfbclient2 firebird3.0-common libldap-2.4-2 gcc make libxml2-dev libssl-dev libbz2-dev \
                       libmcrypt-dev libreadline6-dev libxslt1-dev libcurl4-openssl-dev libenchant-dev libpng-dev \
                       libgmp3-dev libc-client2007e-dev libkrb5-dev firebird-dev libldap2-dev libmemcached-dev \
                       libsqlite3-dev libicu-dev libzip-dev libpng16-16 libmemcached11 libmemcachedutil2 libzip4 && \
    ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h && \
    ln -s /usr/lib/libc-client.a /usr/lib/x86_64-linux-gnu/libc-client.a && \
    docker-php-ext-install -j$(nproc) mysqli gd zip pdo_sqlite intl soap && \
    pecl install memcached && \
    docker-php-ext-enable memcached && \
    curl -L https://getcomposer.org/composer.phar > /usr/bin/composer && chmod +x /usr/bin/composer && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    git lfs install && \
    apt-get install -y nodejs yarn && \
    apt-get purge -y lib*-dev && \
    apt-get autoremove -y && \
    docker-php-source delete && \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /usr/share/man
