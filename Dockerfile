# Use the official PHP 8.2 FPM image
FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    git \
    libicu-dev \
    libmariadb-dev \
    unzip \
    zip \
    zlib1g-dev \
    libjpeg62-turbo-dev \
    nano \
    libicu-dev \
    libxslt1-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install intl extension
RUN apt-get update && apt-get install -y libicu-dev \
    && docker-php-ext-install intl

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory to the Laravel app directory
WORKDIR /var/www/html/my-laravel-app

# Copy the Laravel project files into the container
COPY ./my-laravel-app /var/www/html/my-laravel-app

# Set appropriate permissions for Laravel directories
RUN chown -R www-data:www-data /var/www/html/my-laravel-app && \
    chmod -R 775 /var/www/html/my-laravel-app/storage /var/www/html/my-laravel-app/bootstrap/cache

# Expose port 9000 and start PHP-FPM
EXPOSE 9000
CMD ["php-fpm"]
