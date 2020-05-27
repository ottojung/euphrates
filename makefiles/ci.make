
INSTALL_LIST += $(shell hash guile || echo install-guile)
INSTALL_LIST += $(shell hash racket || echo install-racket)

dependencies: $(INSTALL_LIST)

install-guile:
	apt install -y guile-2.2

install-racket:
	apt install -y racket

.PHONY: dependecies install-guile install-racket

