ifndef VERBOSE
.SILENT:
endif

# default configuration
.DEFAULT_GOAL := help
# tput color : https://linux.101hacks.com/ps1-examples/prompt-color-using-tput/
# eval color value only once to limit number of subshell call
COLOR_RESET := $(shell tput sgr0)
COLOR_RED := $(shell tput setaf 1)
COLOR_GREEN := $(shell tput setaf 2)
COLOR_YELLOW := $(shell tput setaf 3)
BOLD := $(shell tput bold)
BACK_RED := $(shell tput setab 1)
BACK_GREEN := $(shell tput setab 2)


# jekyll configuration
JEKYLL_VERSION=3.8
DOCKER_JEKYLL  = docker run --volume="$(PWD):/srv/jekyll" -p 127.0.0.1:4000:4000/tcp -it jekyll/jekyll:$(JEKYLL_VERSION)
GEM  = $(DOCKER_JEKYLL) gem
BUNDLE  = $(DOCKER_JEKYLL) bundle
JEKYLL  = $(DOCKER_JEKYLL) jekyll


############################################################
### Jekyll
############################################################

## update dependencies
update: _config.yml
	$(BUNDLE) update

## build and serve site
serve: update
	$(JEKYLL) server

## build
build:
	$(JEKYLL) build

############################################################
### Others
############################################################

## List available commands
help:
	@printf "\nInstall Back Makefile\n"
	@printf "\n"
	@printf "${COLOR_YELLOW}Available targets${COLOR_RESET}:\n"
	@awk '/^[a-zA-Z\-\_0-9\@]+:/ { \
		helpLine = match(lastLine, /^## (.*)/); \
		if ( helpLine ) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "${COLOR_GREEN} %-25s ${COLOR_RESET} %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
