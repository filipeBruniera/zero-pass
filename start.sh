#!/bin/sh
set -e

# Gera chave da aplicação se necessário
if [ ! -f ".env" ]; then
  cp .env.example .env
fi

php artisan config:clear
php artisan config:cache
php artisan migrate --force || true

php artisan serve --host=0.0.0.0 --port=8000
