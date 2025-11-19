FROM php:8.3-fpm

RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    libpq-dev \
    libicu-dev \
    zip \
    unzip \
 && docker-php-ext-install \
    pdo_pgsql \
    pgsql \
    mbstring \
    xml \
    dom \
    gd \
    zip \
    intl \
    opcache \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Evitar problema de "dubious ownership" con git
RUN git config --global --add safe.directory /var/www/html

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY . .

RUN composer install --no-dev --optimize-autoloader --no-interaction

RUN chown -R www-data:www-data /var/www/html \
 && chmod -R 755 storage \
 && chmod -R 755 bootstrap/cache

COPY docker/php/php.ini /usr/local/etc/php/conf.d/custom.ini

EXPOSE 9000
CMD ["php-fpm"]
