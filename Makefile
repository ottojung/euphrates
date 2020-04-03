
GUILEDIR = guile
RACKETDIR = racket

TESTFILES = $(shell ls sharedtest/)


DIRPREFIX =
DIRSUFFIX = euphrates

ifeq ($(DIRPREFIX),$(GUILEDIR))
END := scm
else
END := rkt
endif

CURRENT_GIT_COMMIT = $(shell git rev-parse HEAD)

DIR = $(DIRPREFIX)/$(DIRSUFFIX)

TESTFILE =

GUILE_PREFIX = $(shell guile -c '(display (%site-dir))')
RACKET_PREFIX = $(shell racket --eval "(display (path->string (find-system-path 'collects-dir)))")

ifeq ($(DIRPREFIX),$(GUILEDIR))
PREFIX := $(GUILE_PREFIX)
else
PREFIX := $(RACKET_PREFIX)
endif

INSTALL_TGT = "$(PREFIX)/$(DIR)"

all: tguile tracket
	@ echo 'All done'

install: installGuile installRacket
	@ echo 'Install done'

installGuile:
	$(MAKE) installone DIRPREFIX=$(GUILEDIR)

installRacket:
	$(MAKE) installone DIRPREFIX=$(RACKETDIR)

uninstall:
	$(MAKE) uninstallone DIRPREFIX=$(GUILEDIR)
	$(MAKE) uninstallone DIRPREFIX=$(RACKETDIR)

installone: $(INSTALL_TGT)

uninstallone:
	rm -rf "$(PREFIX)/$(shell basename $(DIR))"

$(INSTALL_TGT): all $(PREFIX)
	cp -r "$(DIR)" "$(PREFIX)"

$(PREFIX):
	@ echo "Installation directory doesn't exist! Creating..."
	mkdir -p $@

tguile:
	$(MAKE) common alltests DIRPREFIX=$(GUILEDIR)

tracket:
	$(MAKE) common alltests DIRPREFIX=$(RACKETDIR)

common: | $(DIR) $(DIR)/common.$(END)

$(DIR)/common.$(END): $(DIRPREFIX)/common.header.$(END) lib.scm $(DIRPREFIX)/common.footer.$(END)
	echo ";; euphrates-version-$(CURRENT_GIT_COMMIT)" > $@
	cat $^ >> $@

$(DIR):
	mkdir -p $@

alltests:
	for f in $(TESTFILES) ; do $(MAKE) test TESTFILE="$$f" ; done

test: | $(DIRPREFIX)/test $(DIRPREFIX)/test/$(TESTFILE)

$(DIRPREFIX)/test/$(TESTFILE): $(DIRPREFIX)/test.header.$(END) sharedtest/$(TESTFILE)
	cat $^ > $@

$(DIRPREFIX)/test:
	mkdir -p $@

clean:
	git clean -dfx

