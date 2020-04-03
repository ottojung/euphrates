
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

PREFIX = "$(HOME)/.local/"
PREFIX_FULL = "$(PREFIX)/lib"
INSTALL_TGT = "$(PREFIX_FULL)/$(DIR)"

all: tguile tracket
	@ echo 'all done'

install: installGuile installRacket
	@ echo 'install done'

installGuile:
	$(MAKE) installone DIRPREFIX=$(GUILEDIR)

installRacket:
	$(MAKE) installone DIRPREFIX=$(RACKETDIR)

uninstall:
	$(MAKE) uninstallone DIRPREFIX=$(GUILEDIR)
	$(MAKE) uninstallone DIRPREFIX=$(RACKETDIR)

installone: $(INSTALL_TGT)

uninstallone:
	rm -rf "$(PREFIX_FULL)/$(shell basename $(DIR))"

$(INSTALL_TGT): all $(PREFIX_FULL)
	cp -r "$(DIR)" "$(PREFIX_FULL)"

$(PREFIX_FULL):
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

