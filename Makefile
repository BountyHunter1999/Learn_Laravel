.PHONY: npm artisan composer
.DEFAULT_GOAL := install

# if not defined previously then only it is defined (simply expanded var)
APP_NAME:=primo
COLOR_RESET=\033[0m
COLOR_GREEN=\033[0;32m
COLOR_YELLOW=\033[0;33m
# recursive expanded variable
CHNG_IMG=https://gist.githubusercontent.com/shrish-firefly/b8996113e61b1ac7a785d85ff289cb0b/raw/c28bd14e27448e79c39156d839275db9fcd55579/change_img.sh
PHP_STAN=https://gist.githubusercontent.com/shrish-firefly/09d323eb37dd4558fda6bbd806b796ba/raw/d373891916dd2a4fa38ceddf54dbd5e8521d02d2/phpstan.sh
export MARIO=123
export CONTAINER_NAME=php

create_project:
	@echo "Setting application name to $(APP_NAME)"
	docker compose build composer
	docker compose run --rm composer create-project laravel/laravel .
# docker run --rm composer create-project $${APP_NAME}

# docker run --rm composer create-project 

# mkdir src
install: |
	@sudo bash host_setup.sh
	@cp .env.tmpl .env
	@curl ${CHNG_IMG} | bash
	@curl -s $(PHP_STAN) | sed "s/exec service/exec $${CONTAINER_NAME}/g" > .git/hooks/pre-commit
	@chmod +x .git/hooks/pre-commit
	docker compose up -d nginx --build --force-recreate
	docker compose pull
	docker compose build composer
	docker compose up -d mailpit

composer: |
	docker compose build composer
	docker compose run --rm composer create-project laravel/laravel your-app-name .

# install other composer depedency with
# docker compose run --rm composer require spatie/laravel-permission
npm:
	docker compose run --rm npm install

# compile the assets with
# docker compose run --rm npm run dev
artisan:
	docker compose run --rm artisan migrate
# create post model and migration file
# docker compose run --rm artisan make:model Post --migration

# create certs locally
# - mkcert laravel-docker.test
prod:
	docker compose -f docker-compose.yml -f docker-compose-prod.yml up nginx --build 
# docker compose run --rm php -i | grep opcache
# laravel new `project`
# primoc 

reload_nginx:
	docker compose up -d nginx --build --no-deps

help:
	@echo "Available options"

	@echo "  $(COLOR_GREEN)make composer <composer_command>$(COLOR_RESET)"
	@echo "  $(COLOR_GREEN)make artisan <artisan_command>$(COLOR_RESET)"
	@echo "  $(COLOR_GREEN)make npm <npm_command>$(COLOR_RESET)"
