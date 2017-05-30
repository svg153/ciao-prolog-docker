
pwd ?= `pwd`

ALIAS := ciao
EMACS_PATH ?= ~/.emacs.d
WS_PATH ?= `pwd`/WS


all:
	@docker build --file Dockerfile --tag $(ALIAS) .
	@docker run -ti --name $ -v /tmp/.X11-unix:/tmp/.X11-unix:ro\
	 -e DISPLAY="unix$DISPLAY"\
	 -e UNAME="emacser"\
	 -e GNAME="emacsers"\
	 -e UID="1000"\
	 -e GID="1000"\
	 -v $(WS_PATH):/home/emacs/.emacs.d\
	 -v $(WS_PATH):/mnt/workspace\
	 --name $(ALIAS)
