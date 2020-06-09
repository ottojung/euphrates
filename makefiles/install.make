
include makefiles/common.make

GUILE_PREFIX = $(shell guile -c '(display (%site-dir))')
RACKET_PREFIX = $(shell racket --eval "(display (path->string (find-system-path 'collects-dir)))")

HARD_INSTALL = true

ifeq ($(TARGET),$(GUILEDIR))
PREFIX := $(GUILE_PREFIX)
else
PREFIX := $(RACKET_PREFIX)
endif

LINK_DIRNAME = $(DIRSUFFIX)
LINK_TGT = $(PREFIX)/$(LINK_DIRNAME)
INSTALL_DIRNAME = $(LINK_DIRNAME)-$(CURRENT_GIT_COMMIT)
INSTALL_TGT = $(PREFIX)/$(INSTALL_DIRNAME)

installone: $(INSTALL_TGT) $(LINK_TGT)

uninstallone:
	rm -rf "$(INSTALL_TGT)"
	if $(HARD_INSTALL); then rm -f "$(LINK_TGT)"; fi

LINK_CMD = cd $(PREFIX) && ln --symbolic --force --no-dereference "$(INSTALL_DIRNAME)" "$(LINK_DIRNAME)"

$(INSTALL_TGT): $(PREFIX)
	cp -r "$(DIR)" "$(INSTALL_TGT)"
	if $(HARD_INSTALL); then $(LINK_CMD); fi

$(LINK_TGT): $(PREFIX)
	$(LINK_CMD)

$(PREFIX):
	@ echo "Installation directory doesn't exist! Creating..."
	mkdir -p $@ || (sudo mkdir -p $@ && sudo chown "$USER:$USER" $@)
