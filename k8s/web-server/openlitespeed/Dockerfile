# Use the official Ubuntu base image
FROM ubuntu:jammy

# Set timezone and make installation non-interactive
ENV TZ=Asia/Kolkata
ENV DEBIAN_FRONTEND=noninteractive

# Define PHP and Node.js versions
ENV PHP_VERSION=8.2 \
    LSPHP_VERSION=82 \
    NODE_VERSION=20

# Update package lists and install initial packages
RUN apt-get update && \
    apt-get install -y \
    tzdata \
    software-properties-common \
    git \
    wget \
    curl \
    unzip \
    nano \
    zip && \
    rm -rf /var/lib/apt/lists/*
    
# Add PPA repositories for OpenLiteSpeed and PHP
RUN wget -O - http://rpms.litespeedtech.com/debian/enable_lst_debian_repo.sh | bash && \
    apt-get update
    
# Install OpenLiteSpeed
RUN apt-get install -y openlitespeed

# Install PHP and necessary extensions
RUN apt-get install -y \
    lsphp${LSPHP_VERSION} \
    lsphp${LSPHP_VERSION}-mysql \
    lsphp${LSPHP_VERSION}-common \
    lsphp${LSPHP_VERSION}-opcache \
    lsphp${LSPHP_VERSION}-intl \
    lsphp${LSPHP_VERSION}-curl \
    lsphp${LSPHP_VERSION}-imap \
    lsphp${LSPHP_VERSION}-ldap \
    lsphp${LSPHP_VERSION}-redis \
    lsphp${LSPHP_VERSION}-memcached 

# Update PHP configuration for all configurations
RUN sed -i -e 's/^file_uploads =.*/file_uploads = On/' \
           -e 's/^allow_url_fopen =.*/allow_url_fopen = On/' \
           -e 's/^short_open_tag =.*/short_open_tag = On/' \
           -e 's/^memory_limit =.*/memory_limit = 256M/' \
           -e 's/^;cgi.fix_pathinfo=1.*/cgi.fix_pathinfo = 0/' \
           -e 's/^upload_max_filesize =.*/upload_max_filesize = 100M/' \
           -e 's/^post_max_size =.*/post_max_size = 100M/' \
           -e 's/^max_execution_time =.*/max_execution_time = 360/' \
           /usr/local/lsws/lsphp${LSPHP_VERSION}/etc/php/${PHP_VERSION}/litespeed/php.ini

# Download and install ionCube Loader
RUN wget -O /tmp/ioncube_loaders.zip https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.zip && \
    unzip /tmp/ioncube_loaders.zip -d /tmp && \
    mkdir -p /usr/local/lsws/lsphp82/lib/php/20210902/ && \
    cp /tmp/ioncube/ioncube_loader_lin_8.2.so /usr/local/lsws/lsphp82/lib/php/20210902/ioncube_loader_lin_8.2.so && \
    echo "zend_extension = /usr/local/lsws/lsphp82/lib/php/20210902/ioncube_loader_lin_8.2.so" > /usr/local/lsws/lsphp82/etc/php/8.2/mods-available/00-ioncube.ini && \
    rm -rf /tmp/*

# Install wkhtmltopdf
RUN apt-get update && \
    apt-get install -y wkhtmltopdf
    
# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - && \
    apt-get install -y nodejs

# Create virtual host configuration directory
RUN mkdir -p /usr/local/lsws/conf/vhosts/faveo

# Copy virtual host configuration file
COPY httpd_config.conf /usr/local/lsws/conf/httpd_config.conf
COPY vhconf.conf /usr/local/lsws/conf/vhosts/faveo/vhconf.conf
COPY htpasswd /usr/local/lsws/admin/conf/htpasswd

# Create document root directory and set permissions
RUN mkdir -p /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Set the working directory
WORKDIR /var/www/html

# Expose ports 80 and 443 for HTTP and HTTPS traffic
EXPOSE 80
EXPOSE 443
EXPOSE 7080

# Set entrypoint to OpenLiteSpeed service
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]