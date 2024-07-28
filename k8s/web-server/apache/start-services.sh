#!/bin/bash

# Start PHP-FPM service
service php8.2-fpm start

# Start Apache in the foreground
apache2ctl -D FOREGROUND
