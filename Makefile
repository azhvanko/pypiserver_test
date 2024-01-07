# custom variables
SHELL = /bin/bash

# shortcuts
start:
	docker compose down --remove-orphans
	docker compose up --build -d

clear:
	docker compose down --remove-orphans -v

.PHONY: start clear
