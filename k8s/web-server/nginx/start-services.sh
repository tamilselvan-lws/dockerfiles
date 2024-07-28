#!/bin/bash

# Start PHP-FPM service
service php8.2-fpm start

# Start Nginx service in the foreground
nginx -g "daemon off;"