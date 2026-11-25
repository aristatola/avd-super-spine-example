CURRENT_DIR := $(shell pwd)

.PHONY: help
help: ## Display help message
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: start
start: ## Deploy the lab
	sudo containerlab deploy --debug --topo $(CURRENT_DIR)/clab/topology.clab.yml --max-workers 10 --timeout 5m --reconfigure

.PHONY: stop
stop: ## Destroy the lab
	sudo containerlab destroy --debug --topo $(CURRENT_DIR)/clab/topology.clab.yml --cleanup

# AVD build and deploy

.PHONY: build
build: ## Generate configurations and documentation
	ansible-playbook build.yml

.PHONY: build-twin
build-twin: ## Generate digital twin configurations for the DIGITAL_TWIN inventory group
	ansible-playbook build-twin.yml -e twinventory=DIGITAL_TWIN -e twin_type=act

.PHONY: build-twin-clab
build-twin-clab: ## Generate digital twin configurations for the DIGITAL_TWIN inventory group
	ansible-playbook build-twin.yml -e twinventory=DIGITAL_TWIN -e twin_type=containerlab

.PHONY: deploy
deploy: ## Deploy generated configurations using eAPI
	ansible-playbook deploy.yml
