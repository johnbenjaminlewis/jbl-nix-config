.PHONY: init
init:
	./bin/install.sh

.PHONY: build
build:
	sudo ./bin/darwin-rebuild

.PHONY: build-test
build-test:
	sudo darwin-rebuild switch --flake ./test

.PHONY: format
format:
	nix fmt .
