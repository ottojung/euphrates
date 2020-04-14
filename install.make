
include common.make

GUILE_PREFIX = $(shell guile -c '(display (%site-dir))')
RACKET_PREFIX = $(shell racket --eval "(display (path->string (find-system-path 'collects-dir)))")

ifeq ($(DIRPREFIX),$(GUILEDIR))
PREFIX := $(GUILE_PREFIX)
else
PREFIX := $(RACKET_PREFIX)
endif

INSTALL_TGT = "$(PREFIX)/$(DIR)"

installone: $(INSTALL_TGT)

uninstallone:
	rm -rf "$(PREFIX)/$(shell basename $(DIR))"

$(INSTALL_TGT): $(PREFIX)
	cp -r "$(DIR)" "$(PREFIX)"

$(PREFIX):
	@ echo "Installation directory doesn't exist! Creating..."
	mkdir -p $@
