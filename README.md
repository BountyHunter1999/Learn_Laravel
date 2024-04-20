# How to Get Started?

1. `make first_run`: this will start the containers
2. `docker compose build composer create-project laravel/laravel .`
3. `docker compose run -rm npm install`
4. `docker compose run -rm artisan migrate`

- We have 3 utility containers: composer, npm and artisan
    - we can use those the same way we use them on bare-metal, BUT a key difference here will be that we'll use have `docker compose run -rm` as prefix

> for more info look into this confluence page: https://stabilityhc.atlassian.net/l/cp/6aeZyb6A