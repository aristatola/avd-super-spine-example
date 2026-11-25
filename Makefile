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

<<<<<<< HEAD
<<<<<<< HEAD
.PHONY: deploy
deploy: ## Destroy the lab
=======
.PHONY: build
build: ## Destroy the lab
>>>>>>> 5523af0 (basleine)
=======
.PHONY: deploy
deploy: ## Deploy generated configurations using eAPI
>>>>>>> cc8e22f (Fix Makefile)
	ansible-playbook deploy.yml
