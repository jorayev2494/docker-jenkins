.DEFAULT_GOAL := help

COMPOSE_FILE_PATH := ./docker/docker-compose.yml

init:						## Init
	@make init_project
	@make init_docker

init_project:				## Init Prokect
	# @cp .env.example .env

init_docker:				## Init Docker
	@cp ./docker/.env.example ./docker/.env

install:					## Install project
	@make -s init

pull:						## Pull project
	@docker-compose --file $(COMPOSE_FILE_PATH) pull

build:						## Build project
	@docker-compose --file $(COMPOSE_FILE_PATH) build

build-no-cache:				## Build no cache project
	@docker-compose --file $(COMPOSE_FILE_PATH) build --no-cache

up-build:					## Up and build project
	@docker-compose --file $(COMPOSE_FILE_PATH) up --build -d

up:							## Up project
	@docker-compose --file $(COMPOSE_FILE_PATH) up -d
	@make ps

start-service:						## Start service
	docker-compose --file $(COMPOSE_FILE_PATH) start $(service)

down:						## Down project
	docker-compose --file $(COMPOSE_FILE_PATH) down --remove-orphans

stop-service:						## Stop service
	docker-compose --file $(COMPOSE_FILE_PATH) stop $(service)

restart:					## Restart project
	@docker-compose --file $(COMPOSE_FILE_PATH) restart

bash:						## Project bash terminal
	@docker-compose --file $(COMPOSE_FILE_PATH) exec jenkins bash

ps:							## Show project process
	docker-compose --file $(COMPOSE_FILE_PATH) ps

jenkins-logs:				## Jenkins Logs
	@docker-compose --file $(COMPOSE_FILE_PATH) logs jenkins

jenkins-logs-f:				## Jenkins Logs and follow
	@docker-compose --file $(COMPOSE_FILE_PATH) logs -f jenkins

.PHONY: help
help:				## Show Project commands
	@#echo ${Cyan}"\t\t This project 'job' REST API Server!"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo ${Red}"----------------------------------------------------------------------"
