include .env

.PHONY: up down stop prune ps shell logs

default: up

up:
	@echo "Starting up containers for for $(PROJECT_NAME)..."
	docker-compose pull
	docker-compose up -d --remove-orphans
#	@dir=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))        
#	@cd $(dir)
#	@rsync-setup/php/setup >& /dev/null
#	@rsync-setup/php/client-start-sync.sh  >& /dev/null
#	@rsync-setup/php/watch.sh >& /dev/null &
#	@rsync-setup/nginx/setup >& /dev/null
#	@rsync-setup/nginx/client-start-sync.sh >& /dev/null
#	@rsync-setup/nginx/watch.sh >& /dev/null & 
#	@alpine_support/cp_to_container >& /dev/null 

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

shell: fpm

fpm:
	docker exec --user root -ti -e COLUMNS=$(shell tput cols) -e LINES=$(shell tput lines) $(shell  docker ps --filter ancestor=knesser2/php --format '{{ .ID }}'  ) bash

fpmi:
	docker exec -i -e COLUMNS=$(shell tput cols) -e LINES=$(shell tput lines) $(shell  docker ps --filter ancestor=knesser2/php --format '{{ .ID }}'  ) sh -c "${CMD}"

logs:
	@docker-compose logs -f $(filter-out $@,$(MAKECMDGOALS))

nginx:
	docker exec -ti -e COLUMNS=$(shell tput cols) -e LINES=$(shell tput lines) $(shell  docker ps --filter ancestor=docker4phpnewnfs_nginx    --format '{{ .ID }}'  ) sh
# https://stackoverflow.com/a/6273809/1826109
%:
	@:
