ENV?=dev

dca := docker-compose \
	-f docker-compose.yml \
	-f docker-compose.override.yml

dct := $(dca) \
	-f docker-compose.test.yml \
	-f docker-compose.test.override.yml

de-php := docker-compose exec php sh -c

### ---------------------
###	Init
### ---------------------
init: up composer-install migrate

###
composer:
	$(de-php) '$(MAKECMDGOALS)'

migrate:
	$(de-php) 'bin/console doctrine:migrations:migrate'

### ---------------------
###	Develop
### ---------------------
up:
	$(dca) up -d

ups:
	$(dca) up

down:
	$(dca) down

sh:
	$(de-php) 'bash'

### ---------------------
###	Test
### ---------------------
test-up:
	$(dct) up -d

test-ups:
	$(dct) up

test-down:
	$(dct) down

test-migrate:
	$(de-php) 'bin/console doctrine:migrations:migrate --env=test'

### ---------------------
###	Builds
### ---------------------

### ---------------------
###	Help
### ---------------------
# ignore all not-found targets
%:
	@: