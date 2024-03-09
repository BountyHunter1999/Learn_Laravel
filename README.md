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

## Models, migrations, and controllers

- **Models**: provide a powerful and enjoyable interface for us to interact with tables in our database
- **Migrations**: allows us to easily create and modify the tables in our database. This ensures that the same database structure exsts everywhere that our application runs
- **Controllers**: are responsible for processing requests made to our applicaion and returning a response.

- `artisan make:model` will create these 3 components for us all at once
- run `./vendor/bin/sail php artisan make:model -mrc Chirp`:
  - `-m` generates a migration file along with the model
  - `-r` generates a resource controller along with the model
    - this provides CRUD functionality for the model
  - `-c` generates a factory for the model
    - factories are used to define the structure of fake model instances for testing purposes
