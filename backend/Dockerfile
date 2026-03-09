FROM php:8.2-fpm

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    git unzip libicu-dev libonig-dev libzip-dev zip nginx \
    && docker-php-ext-install intl pdo pdo_mysql zip

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

# Copiar proyecto
COPY . .

# Instalar dependencias Symfony
RUN composer install --no-dev --optimize-autoloader \
    && chown -R www-data:www-data /var/www/var

# Copiar configuración nginx para Symfony
COPY nginx.conf /etc/nginx/sites-enabled/default

# Exponer puertos
EXPOSE 80

# Arrancar Nginx y PHP-FPM
CMD ["sh", "-c", "service nginx start && php-fpm"]