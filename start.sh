#!/bin/sh
set -e

if [ ! -f ".env" ]; then
  cp .env.example .env
fi

php artisan key:generate --force
php artisan config:clear
php artisan config:cache
php artisan migrate --force || true

chmod -R 775 storage bootstrap/cache
chown -R www-data:www-data storage bootstrap/cache

php artisan serve --host=0.0.0.0 --port=${PORT:-8000}
