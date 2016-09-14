.DEFAULT_GOAL := help

run: ## Pulling docker image and Start up netbox
	@echo "Starting netbox"
	docker-compose up -d

stop: ## Stopping docker without save
	@echo "Stopping netbox"
	docker-compose stop

save: ## Saving changes and uploading it to Docker Hub
	docker commit $$(docker ps |grep 'postgres' |awk '{print $$1}') vcjp/postgres:9.6
	docker push vcjp/postgres:9.6

log: ## Show docker-compose log
	docker-compose logs

.PONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
