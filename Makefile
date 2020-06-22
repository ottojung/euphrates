include makefiles/common.make

all: libs build-tests
	@ echo 'All done'

libs: tguile tracket

install: installGuile installRacket
	@ echo 'Install done'

installGuile: tguile
	$(MAKE) -f $(INSTALL_MAKE) installone BACKEND=$(GUILEDIR)

installRacket: tracket
	$(MAKE) -f $(INSTALL_MAKE) installone BACKEND=$(RACKETDIR)

uninstall:
	$(MAKE) -f $(INSTALL_MAKE) uninstallone BACKEND=$(GUILEDIR)
	$(MAKE) -f $(INSTALL_MAKE) uninstallone BACKEND=$(RACKETDIR)

tguile:
	$(MAKE) common BACKEND=$(GUILEDIR)

tracket:
	$(MAKE) common BACKEND=$(RACKETDIR)

common: | $(DIR) $(DIR)/common.$(END)

$(DIR)/common.$(END): $(DIRPREFIX)/common.header.$(END) src/lib.scm $(DIRPREFIX)/common.footer.$(END)
	echo ";; euphrates-version-$(CURRENT_GIT_COMMIT)" > $@
	cat $^ >> $@
	sed -i "s/EUPHRATES_VERSION_STRING_SED_PLACEHOLDER/$(CURRENT_GIT_COMMIT)/g" "$@"

$(DIR):
	mkdir -p $@

test: all
	$(MAKE) testall -f makefiles/ci.make

quick-test: all
	$(MAKE) quick-test -f makefiles/ci.make

build-tests:
	$(MAKE) build-target-tests BACKEND=$(GUILEDIR)
	$(MAKE) build-target-tests BACKEND=$(RACKETDIR)

build-target-tests:
	@ echo "files: $(TESTFILES)"
	for f in $(TESTFILES) ; do $(MAKE) build-one-test BACKEND=$(BACKEND) TESTFILE="$$f" ; done

build-one-test: | $(BUILDDIR)/test/$(DIRPREFIX) $(BUILDDIR)/test/$(DIRPREFIX)/$(TESTFILE)

$(BUILDDIR)/test/$(DIRPREFIX)/$(TESTFILE): test/$(BACKEND)/test.header.$(END) test/sharedtest/$(TESTFILE)
	cat $^ > $@

$(BUILDDIR)/test/$(DIRPREFIX):
	mkdir -p $@

clean:
	rm -rf $(BUILDDIR)

