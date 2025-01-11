# Looking into Laravel

## Breeze for authentication

- Includes Authentication features like:
    - Login
    - Registration
    - Password Reset
    - Email Verification
    - Password Confirmation
- `make comp_command CMD='composer require laravel/breeze --dev'`
- `composer require laravel/breeze --dev`
- `php artisan breeze:install blade`: this will install and configure our front-end dependencies
- `npm run dev`: start the vite development server to automatically recompile our CSS
- `php artisan migrate`

- username: Mikeyy
- email: mikeyy@mikeyy.com
- password: fTI!PugxjhI!RZ6u

## Models, migrations, and controllers

- **Models**: provide a powerful and enjoyable interface for us to interact with tables in our database
- **Migrations**: allows us to easily create and modify the tables in our database. This ensures that the same database structure exsts everywhere that our application runs
- **Controllers**: are responsible for processing requests made to our applicaion and returning a response.

- `artisan make:model` will create these 3 components for us all at once
- Run `php artisan make:model -mrc Chirp`:
    - **`-m` (Migration)**: Generates a migration file for the model, allowing us to define the database schema for the corresponding table.
    - **`-r` (Resource Controller)**: Generates a resource controller for the model, pre-configured with standard CRUD methods (`index`, `create`, `store`, `show`, `edit`, `update`, `destroy`).
    - **`-c` (Factory)**: Generates a factory for the model, used to define the structure of fake data for testing or database seeding.
