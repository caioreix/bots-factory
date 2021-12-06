.PHONY: deploy

THIS_FILE=$(lastword $(MAKEFILE_LIST))

APP_NAME=bf-discord
PROCESS_TYPE=worker

DISCORD_IMAGE=bf/discord

local-start:
	@cd ./cmd/channels/discord && $(MAKE) start

local-stop:
	@cd ./cmd/channels/discord && $(MAKE) stop

container-login:
	heroku container:login

container-release:
	heroku container:release $(PROCESS_TYPE) --app $(APP_NAME)

docker-build:
	@docker build --no-cache --pull -f ./build/channels/discord/Dockerfile -t $(DISCORD_IMAGE) .

tag:
	@docker tag $(DISCORD_IMAGE):latest registry.heroku.com/$(APP_NAME)/$(PROCESS_TYPE)

push-tag:
	@docker push registry.heroku.com/$(APP_NAME)/$(PROCESS_TYPE)

build-push-image:
	@$(MAKE) -f $(THIS_FILE) container-login
	@$(MAKE) -f $(THIS_FILE) docker-build
	@$(MAKE) -f $(THIS_FILE) tag
	@$(MAKE) -f $(THIS_FILE) push-tag

deploy:
	@echo "--- STARTING DISCORD DEPLOY ---"
	@$(MAKE) -f $(THIS_FILE) build-push-image
	@$(MAKE) -f $(THIS_FILE) container-release
	@echo "--- DISCORD DEPLOY SUCCESS!---"
