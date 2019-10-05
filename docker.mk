include .env

.PHONY: up down stop prune ps shell logs

default: up

up:
	@echo "Starting up containers for for $(PROJECT_NAME)..."
	docker-compose pull
	docker-compose up -d --remove-orphans
	dir=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))        
	cd $(dir)
	rsync-setup/php/setup
	rsync-setup/php/client-start-sync.sh 
	rsync-setup/php/watch.sh

down: stop

stop:
	@echo "Stopping containers for $(PROJECT_NAME)..."
	@docker-compose stop
	@rsync-setup/php/stop-fswatch.sh

prune:
	@echo "Removing containers for $(PROJECT_NAME)..."
	@docker-compose down -v

ps:
	@docker ps --filter name='$(PROJECT_NAME)*'

shell:
	docker exec -ti -e COLUMNS=$(shell tput cols) -e LINES=$(shell tput lines) $(shell docker ps --filter name='$(PROJECT_NAME)_php_cli' --format "{{ .ID }}") sh


fpm:
	docker exec -ti -e COLUMNS=$(shell tput cols) -e LINES=$(shell tput lines) $(shell  docker ps --filter ancestor=wodby/php:7.2-dev-4.11.5 --format '{{ .ID }}'  ) sh
logs:
	@docker-compose logs -f $(filter-out $@,$(MAKECMDGOALS))

# https://stackoverflow.com/a/6273809/1826109
%:
	@:
