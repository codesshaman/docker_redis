name = Redis DB

VAR :=				# Cmd arg var
NO_COLOR=\033[0m	# Color Reset
OK=\033[32;01m		# Green Ok
ERROR=\033[31;01m	# Error red
WARN=\033[33;01m	# Warning yellow

all:
	@printf "Launch configuration ${name}...\n"
	@docker-compose -f ./docker-compose.yml up -d

help:
	@echo -e "$(OK)==== Все команды для конфигурации ${name} ===="
	@echo -e "$(WARN)- make				: Launch configuration"
	@echo -e "$(WARN)- make build			: Configuration build"
	@echo -e "$(WARN)- make connect			: Exec to container"
	@echo -e "$(WARN)- make down			: Stopping the configuration"
	@echo -e "$(WARN)- make ps			: Show the configuration "
	@echo -e "$(WARN)- make push			: Push changes to the github"
	@echo -e "$(WARN)- make re			: Rebuild the configuration"
	@echo -e "$(WARN)- make clean			: Clean all images"
	@echo -e "$(WARN)- make fclean			: Full clean of all configurations$(NO_COLOR)"

build:
	@printf "Сonfiguration ${name} build...\n"
	@docker-compose -f ./docker-compose.yml up -d --build

connect:
	@docker exec -it redis bash

down:
	@printf "Stopping the configuration ${name}...\n"
	@docker-compose -f ./docker-compose.yml down

ps:
	@printf "Show the configuration ${name}......\n"
	@docker-compose -f ./docker-compose.yml ps

push:
	@bash push.sh

re:
	@printf "Rebuild the configuration ${name}...\n"
	@docker-compose -f ./docker-compose.yml down
	@docker-compose -f ./docker-compose.yml up -d --build

clean: down
	@printf "Clean all images...\n"
	@docker system prune -a

fclean:
	@printf "Full clean of all configurations\n"
#	@docker stop $$(docker ps -qa)
#	@docker system prune --all --force --volumes
#	@docker network prune --force
#	@docker volume prune --force

.PHONY	: all build down ps re scan show clean fclean
