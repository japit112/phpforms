# Use the official PHP Apache image
FROM php:8.3-apache

# Install required PHP extensions and tools
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    curl \
    && docker-php-ext-install \
    mysqli \
    pdo \
    pdo_mysql \
    && rm -rf /var/lib/apt/lists/*

# Enable useful Apache modules
RUN a2enmod rewrite headers

# Prepare document root and copy source code
WORKDIR /var/www/html
RUN rm -rf /var/www/html/*
COPY . /var/www/html

# Set secure default permissions
RUN chown -R www-data:www-data /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \;

# Default port for Apache
EXPOSE 80

# Apache's default CMD serves /var/www/html
