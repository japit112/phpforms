# Use official PHP Apache image
FROM php:8.2-apache

# Copy project files into container
COPY . /var/www/html/

# Set working directory
WORKDIR /var/www/html/

# Expose port 80 (default for Apache)
EXPOSE 80
