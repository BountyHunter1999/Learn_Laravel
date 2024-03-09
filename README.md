# Learn_Laravel

- `curl -s "https://laravel.build/chirper" | bash`
- `cd chirper && ./vendor/bin/sail up`

## Run commands

```
./vendor/bin/sail php --version
./vendor/bin/sail artisan --version
./vendor/bin/sail composer --version
./vendor/bin/sail npm --version
```

## Breeze for authentication

- `./vendor/bin/sail composer require laravel/breeze --dev`
- `./vendor/bin/sail php artisan breeze:install blade`: this will install and configure our front-end dependencies
- `./vendor/bin/sail npm run dev`: start the vite development server to automatically recompile our CSS
- `./vendor/bin/sail php artisan migrate`

- username: Mikeyy
- email: mikeyy@mikeyy.com
- password: fTI!PugxjhI!RZ6u
