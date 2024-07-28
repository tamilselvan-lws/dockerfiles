# Use the official Ubuntu base image
FROM ubuntu:jammy

# Set environment variables
ENV TZ=Asia/Kolkata \
    DEBIAN_FRONTEND=noninteractive 

# Define PHP and Node.js versions
ENV PHP_VERSION=8.2 \
    NODE_VERSION=20

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
    zip \
    supervisor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add PPA repositories for Apache2 and PHP
RUN add-apt-repository ppa:ondrej/apache2 && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update

# Install Apache2
RUN apt-get install -y apache2

# Install PHP and necessary extensions
RUN apt-get install -y \
    php${PHP_VERSION} \
    libapache2-mod-php${PHP_VERSION} \
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


# Copy Supervisor configuration file
COPY faveo-worker.conf /etc/supervisor/conf.d/faveo-worker.conf

# Set the working directory
WORKDIR /var/www/html

# Set entrypoint to Supervisor service
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]