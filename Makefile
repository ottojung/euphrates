include common.make

all: tguile tracket
	@ echo 'All done'

install: installGuile installRacket
	@ echo 'Install done'

installGuile: tguile
	$(MAKE) -f install.make installone DIRPREFIX=$(GUILEDIR)

installRacket: tracket
	$(MAKE) -f install.make installone DIRPREFIX=$(RACKETDIR)

uninstall:
	$(MAKE) -f install.make uninstallone DIRPREFIX=$(GUILEDIR)
	$(MAKE) -f install.make uninstallone DIRPREFIX=$(RACKETDIR)

tguile:
	$(MAKE) common alltests DIRPREFIX=$(GUILEDIR)

tracket:
	$(MAKE) common alltests DIRPREFIX=$(RACKETDIR)

common: | $(DIR) $(DIR)/common.$(END)

$(DIR)/common.$(END): $(DIRPREFIX)/common.header.$(END) lib.scm $(DIRPREFIX)/common.footer.$(END)
	echo ";; euphrates-version-$(CURRENT_GIT_COMMIT)" > $@
	cat $^ >> $@
	if [ "$(DIRPREFIX)" = "guile" ]; then scripts/replace-export-list.sh ; fi

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

