include makefiles/common.make

all: tguile tracket
	@ echo 'All done'

install: installGuile installRacket
	@ echo 'Install done'

installGuile: tguile
	$(MAKE) -f $(INSTALL_MAKE) installone TARGET=$(GUILEDIR)

installRacket: tracket
	$(MAKE) -f $(INSTALL_MAKE) installone TARGET=$(RACKETDIR)

uninstall:
	$(MAKE) -f $(INSTALL_MAKE) uninstallone TARGET=$(GUILEDIR)
	$(MAKE) -f $(INSTALL_MAKE) uninstallone TARGET=$(RACKETDIR)

tguile:
	$(MAKE) common alltests TARGET=$(GUILEDIR)

tracket:
	$(MAKE) common alltests TARGET=$(RACKETDIR)

common: | $(DIR) $(DIR)/common.$(END)

$(DIR)/common.$(END): $(DIRPREFIX)/common.header.$(END) src/lib.scm $(DIRPREFIX)/common.footer.$(END)
	echo ";; euphrates-version-$(CURRENT_GIT_COMMIT)" > $@
	cat $^ >> $@
	if [ "$(TARGET)" = "$(GUILEDIR)" ]; then scripts/replace-export-list.sh ; fi

$(DIR):
	mkdir -p $@

alltests:
	for f in $(TESTFILES) ; do $(MAKE) test TARGET=$(TARGET) TESTFILE="$$f" ; done

test: | $(DIRPREFIX)/test $(DIRPREFIX)/test/$(TESTFILE)

$(DIRPREFIX)/test/$(TESTFILE): $(DIRPREFIX)/test.header.$(END) src/sharedtest/$(TESTFILE)
	cat $^ > $@

$(DIRPREFIX)/test:
	mkdir -p $@

clean:
	git clean -dfx

