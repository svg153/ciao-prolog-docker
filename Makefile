SHELL := /bin/bash


pwd ?= `pwd`

ALIAS ?= ciao
UID := `ìd -u`
GID := `ìd -g`
#EMACS_PATH ?= ~/.emacs.d
EMACS_PATH ?= $(pwd)/.emacs.d
WS_PATH ?= $(pwd)/WS

EXISTS := $(shell docker ps -a -q -f name=$(ALIAS))
RUNNED := $(shell docker ps -q -f name=$(ALIAS))
STALE_IMAGES := $(shell docker images | grep "<none>" | awk '{print($$3)}')


all: clean
	@docker build --file Dockerfile --tag $(ALIAS) .
	@docker run -d --name $(ALIAS) \
		-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
		-e DISPLAY="unix$$DISPLAY" \
		-e UNAME="emacser" \
		-e GNAME="emacsers" \
		-e UID="1000" \
		-e GID="1000" \
		-v $(WS_PATH):/home/emacs/workspace:rw \
		$(ALIAS) emacs

enter: clean
	@docker run -ti --name $(ALIAS) \
		-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
		-e DISPLAY="unix$$DISPLAY" \
		-e UNAME="emacser" \
		-e GNAME="emacsers" \
		-e GID="1000" \
		-e UID="1000" \
		-v $(EMACS_PATH):/home/emacs/.emacs.d:rw \
		-v $(WS_PATH):/mnt/workspace:rw \
		$(ALIAS) /bin/bash

clean:
ifneq "$(RUNNED)" ""
	@docker kill $(ALIAS)
endif
ifneq "$(STALE_IMAGES)" ""
	@docker rmi -f $(STALE_IMAGES)
endif

original:
	$(eval ALIAS := emacs-ori)
ifneq "$(RUNNED)" ""
	$(shell docker stop $(ALIAS))
endif
ifneq "$(EXISTS)" ""
	$(shell docker container rm $(ALIAS))
endif
	docker run -ti --name $(ALIAS) -v /tmp/.X11-unix:/tmp/.X11-unix:ro\
		-e DISPLAY="unix$$DISPLAY"\
		-e UNAME="emacser"\
		-e GNAME="emacsers"\
		-e UID="1000"\
		-e GID="1000"\
		-v $(EMACS_PATH):/home/emacs/.emacs.d \
		-v $(WS_PATH):/mnt/workspace \
		jare/emacs emacs
