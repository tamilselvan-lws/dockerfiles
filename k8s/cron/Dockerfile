# Use the official Ubuntu base image
FROM ubuntu:jammy

# Set environment variables
ENV TZ=Asia/Kolkata \
    DEBIAN_FRONTEND=noninteractive 

# Define PHP versions
ENV PHP_VERSION=8.2

# Update package lists and install initial packages
RUN apt-get update && \
    apt-get install -y \
    tzdata \
    software-properties-common \
    ca-certificates \
    git \
    wget \
    curl \
    unzip \
    nano \
    zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add PPA repositories for Apache2 and PHP
RUN add-apt-repository ppa:ondrej/php && \
    apt-get update

# Install PHP and necessary extensions
RUN apt-get install -y \
    php${PHP_VERSION} \
    php${PHP_VERSION}-mysql \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-common \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-soap \
    php${PHP_VERSION}-gd \
    php${PHP_VERSION}-opcache \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-bcmath \
    php${PHP_VERSION}-intl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-imap \
    php${PHP_VERSION}-ldap \
    php${PHP_VERSION}-gmp \
    php${PHP_VERSION}-redis \
    php${PHP_VERSION}-memcache

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN rm -rf /var/www/html

RUN mkdir -p /var/www/html; \
    chown www-data:www-data /var/www/html; \
    chmod 1777 /var/www/html

# Copy the faveocloud.zip file
COPY faveocloud.zip /var/www/faveocloud.zip

# Set the working directory
WORKDIR /var/www/html

# Set the default command to start PHP in interactive mode
CMD ["/bin/bash"]
