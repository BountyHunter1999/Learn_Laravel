.PHONY: npm artisan composer

.DEFAULT_GOAL := install

# if not defined previously then only it is defined (simply expanded var)
APP_NAME:=primo
# recursive expanded variable
CHNG_IMG=https://gist.githubusercontent.com/shrish-firefly/b8996113e61b1ac7a785d85ff289cb0b/raw/c28bd14e27448e79c39156d839275db9fcd55579/change_img.sh
PHP_STAN=https://gist.githubusercontent.com/shrish-firefly/09d323eb37dd4558fda6bbd806b796ba/raw/d373891916dd2a4fa38ceddf54dbd5e8521d02d2/phpstan.sh
export CONTAINER_NAME=php


install: ## sets up primo for docker use (first run)
	@sudo bash host_setup.sh
	@cp .env.tmpl .env
	@curl ${CHNG_IMG} | bash
	@curl -s $(PHP_STAN) | sed "s/exec service/exec $${CONTAINER_NAME}/g" > .git/hooks/pre-commit
	@chmod +x .git/hooks/pre-commit
	docker compose up -d nginx --build --force-recreate
	docker compose pull
	docker compose build composer
	docker compose up -d mailpit


migrate: ## run migrate
	docker compose run --rm artisan migrate

prod:
	docker compose -f docker-compose.yml -f docker-compose-prod.yml up nginx --build 

artisan_serve: ## artisan serve command
	docker compose run --rm -p 8000:8000 artisan serve --host 0.0.0.0 

run_dev: ## npm run dev
	docker compose run --rm -p 5173:5173 npm run dev

reload_nginx: ## reload nginx
	docker compose up -d nginx --build --no-deps

pest: ## run pest
	echo "Running Pest"

help:
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-30s\033[0m %s\n", $$1, $$2}'
# @egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-30s\033[0m %s\n", $$1, $$2}'
