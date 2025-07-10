FROM php:8.3-fpm

# Instala dependências
RUN apt-get update && apt-get install -y \
    git curl libpng-dev libonig-dev libxml2-dev zip unzip libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql mbstring exif pcntl bcmath gd

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Define diretório da aplicação
WORKDIR /var/www

# Copia arquivos do projeto
COPY . .

# Instala dependências PHP
RUN composer install --optimize-autoloader --no-dev

# Permissões
RUN chown -R www-data:www-data /var/www && chmod -R 755 /var/www

# Porta padrão do Laravel
EXPOSE 8000

# Script de entrada
CMD ["sh", "start.sh"]
