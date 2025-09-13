# syntax=docker/dockerfile:1
FROM php:8.2-apache

# Install required PHP extensions and enable Apache modules
RUN set -eux; \
    docker-php-ext-install mysqli pdo_mysql; \
    a2enmod rewrite; \
    apt-get update; apt-get install -y --no-install-recommends curl; rm -rf /var/lib/apt/lists/*

# Copy application source
COPY . /var/www/html

# Ensure proper permissions for Apache user
RUN chown -R www-data:www-data /var/www/html

# Expose HTTP port
EXPOSE 80

# Healthcheck to ensure Apache/PHP is responding
HEALTHCHECK --interval=30s --timeout=5s --retries=3 CMD curl -fsS http://localhost/ || exit 1
