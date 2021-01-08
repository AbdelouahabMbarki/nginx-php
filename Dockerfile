FROM php:7.2-fpm
WORKDIR "/application"


# Install selected extensions and other stuff
# Install system packages for PHP extensions recommended for Yii 2.0 Framework

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get -y install \
        gnupg2 && \
        curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-key update && \
    apt-get update && \
    apt-get -y install \
            supervisor \
            nginx \
            g++ \
            git \
            bash-completion \
            zip  \
            unzip  \
            curl \
            imagemagick \
            libfreetype6-dev \
            libcurl3-dev \
            libicu-dev \
            libmcrypt-dev \
            libfreetype6-dev \
            libjpeg-dev \
            libjpeg62-turbo-dev \
            libmagickwand-dev \
            libmcrypt-dev \
            libpq-dev \
            libpng-dev \
            zlib1g-dev \
            openssh-client \
            libxml2-dev \
            nano \
            linkchecker \
            nodejs \
        --no-install-recommends && \
        apt-get clean

RUN  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install PHP extensions required for Yii 2.0 Framework
RUN docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-configure bcmath && \
    docker-php-ext-install \
        soap \
        zip \
        curl \
        bcmath \
        exif \
        gd \
        iconv \
        intl \
        mbstring \
        opcache \
        pdo \
        pdo_pgsql  \
        pgsql


RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/

RUN apt-get install -y --no-install-recommends libmagickwand-dev && \
    pecl install imagick-3.4.3 && \
    docker-php-ext-enable imagick

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer


RUN echo "upload_max_filesize = 100M" > /usr/local/etc/php/php.ini && \
    echo "post_max_size = 108M" >> /usr/local/etc/php/php.ini && \
    echo "max_execution_time = 300" >> /usr/local/etc/php/php.ini && \
    echo "memory_limit = 256M" >> /usr/local/etc/php/php.ini


# Install git
RUN apt-get update \
    && apt-get -y install git \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*
    

