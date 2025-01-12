.PHONY: composer

CMD='composer require laravel/breeze --dev'

setup_project:
	docker compose run --rm  -v $$(pwd):/var/www/html -w /var/www/html composer composer create-project laravel/laravel chirper
	sudo chown -R $$(id -un):$$(id -gn) chirper
	mv -v chirper/* chirper/.[!.]* .
	rm -rf chirper

serve:
	docker compose exec app php artisan serve --host=0.0.0.0

composer:
	docker compose run --rm  -v $$(pwd):/var/www/html -w /var/www/html composer bash

comp_command:
	docker compose run --rm  -v $$(pwd):/var/www/html -w /var/www/html composer $(CMD)

