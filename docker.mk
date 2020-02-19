include .env

.PHONY: up down stop prune ps shell logs

default: up

up:
	@echo "Starting up containers for for $(PROJECT_NAME)..."
	docker-compose pull
	docker-compose up -d --remove-orphans
	@dir=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))        
	@cd $(dir)
	@echo 1
	@rsync-setup/php/setup >& /dev/null
	@echo 2
	@rsync-setup/php/client-start-sync.sh  >& /dev/null
	@echo 3
	@rsync-setup/php/watch.sh >& /dev/null &
	@echo 4
	rsync-setup/nginx/setup >& /dev/null
	@echo 5
	rsync-setup/nginx/client-start-sync.sh >& /dev/null
	@echo 6
	@rsync-setup/nginx/watch.sh >& /dev/null & 
	@echo 7 
	@alpine_support/cp_to_container >& /dev/null 
	@echo 8
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
	docker exec --user root -ti -e COLUMNS=$(shell tput cols) -e LINES=$(shell tput lines) $(shell  docker ps --filter name=$(PROJECT_NAME)_php --format '{{ .ID }}'  ) bash

fpmi:
	docker exec -i -e COLUMNS=$(shell tput cols) -e LINES=$(shell tput lines) $(shell  docker ps --filter ancestor=wodby/php:7.2-dev-4.11.5 --format '{{ .ID }}'  ) sh -c "${CMD}"

logs:
	@docker-compose logs -f $(filter-out $@,$(MAKECMDGOALS))

nginx:
	docker exec -ti -e COLUMNS=$(shell tput cols) -e LINES=$(shell tput lines) $(shell  docker ps --filter name=$(PROJECT_NAME)_nginx  --format '{{ .ID }}'  ) sh
# https://stackoverflow.com/a/6273809/1826109
%:
	@:
