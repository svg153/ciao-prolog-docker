#Variables
SHELL := /bin/bash
pwd ?= `pwd`
ALIAS ?= ciao
UID := `id -u`
GID := `id -g`
EMACS_PATH ?= $(pwd)/.emacs.d
WORKSPACE_PATH ?= $(pwd)/WS
WORKSPACE_DOCKER_PATH ?= /home/emacs/workspace

# Find stopped images
EXISTS := $(shell docker ps -a -q -f name=$(ALIAS))
# Find running images
RUNNED := $(shell docker ps -q -f name=$(ALIAS))
# Find old images
STALE_IMAGES := $(shell docker images | grep "<none>" | awk '{print($$3)}')


all: clean build run


build:
	@docker build \
		--file Dockerfile \
		--tag $(ALIAS) \
		--build-arg WORKSPACE_ARG=$(WORKSPACE_DOCKER_PATH) \
		.


run:
	@docker run \
	    -d \
		--name $(ALIAS) \
		-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
		-e DISPLAY="unix$$DISPLAY" \
		-e UNAME="emacser" \
		-e GNAME="emacsers" \
		-e UID="1000" \
		-e GID="1000" \
		-e WORKSPACE=$(WORKSPACE_DOCKER_PATH) \
		-v $(WORKSPACE_PATH):$(WORKSPACE_DOCKER_PATH):rw \
		$(ALIAS) emacs
		
		
enter: clean
	@docker run -ti --name $(ALIAS) \
		-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
		-e DISPLAY="unix$$DISPLAY" \
		-e UNAME="emacser" \
		-e GNAME="emacsers" \
		-e UID="1000" \
		-e GID="1000" \
		-v $(EMACS_PATH):/home/emacs/.emacs.d:rw \
		-e WORKSPACE=$(WORKSPACE_DOCKER_PATH) \
		-v $(WORKSPACE_PATH):$(WORKSPACE_DOCKER_PATH):rw \
		$(ALIAS) /bin/bash
		
		
ciao:
	@docker run -ti --rm --name $(ALIAS) \
		-e UNAME="emacser" \
		-e GNAME="emacsers" \
		-e UID="1000" \
		-e GID="1000" \
		-e WORKSPACE=$(WORKSPACE_DOCKER_PATH) \
		-v $(WORKSPACE_PATH):$(WORKSPACE_DOCKER_PATH):rw \
		$(ALIAS) /bin/bash
		
		
clean:
ifneq "$(RUNNED)" ""
	@docker kill $(ALIAS)
endif
	-@docker rm $(ALIAS)
ifneq "$(STALE_IMAGES)" ""
	@docker rmi -f $(STALE_IMAGES)
endif


cleanAll:
	-@docker rmi $(ALIAS)


original:
	$(eval ALIAS := emacs-ori)
ifneq "$(RUNNED)" ""
	$(shell docker stop $(ALIAS))
endif
ifneq "$(EXISTS)" ""
	$(shell docker container rm $(ALIAS))
endif
	docker run -ti --name $(ALIAS) \
	    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
		-e DISPLAY="unix$$DISPLAY" \
		-e UNAME="emacser" \
		-e GNAME="emacsers" \
		-e UID="$(UID_tmp)" \
		-e GID="$(GID_tmp)" \
		-v $(EMACS_PATH):/home/emacs/.emacs.d \
		-e WORKSPACE=$(WORKSPACE_DOCKER_PATH) \
		-v $(WORKSPACE_PATH):$(WORKSPACE_DOCKER_PATH):rw \
		jare/emacs emacs
