
GUILEDIR = guile
RACKETDIR = racket

TESTFILES = $(shell ls sharedtest/)


DIRPREFIX =
DIRSUFFIX = my-$(DIRPREFIX)-std
END =

CURRENT_GIT_COMMIT = $(shell git rev-parse HEAD)

DIR = $(DIRPREFIX)/$(DIRSUFFIX)

TESTFILE =

all: tguile tracket
	@ echo 'all done'

tguile:
	$(MAKE) common alltests DIRPREFIX=$(GUILEDIR) END=scm

tracket:
	$(MAKE) common alltests DIRPREFIX=$(RACKETDIR) END=rkt

common: | $(DIR) $(DIR)/common.$(END)

$(DIR)/common.$(END): $(DIRPREFIX)/common.header.$(END) lib.scm $(DIRPREFIX)/common.footer.$(END)
	echo ";; my-lisp-std-version-$(CURRENT_GIT_COMMIT)" > $@
	cat $^ >> $@

$(DIR):
	mkdir -p $@

alltests:
	for f in $(TESTFILES) ; do $(MAKE) test TESTFILE="$$f" ; done

test: | $(DIR)/test $(DIR)/test/$(TESTFILE)

$(DIR)/test/$(TESTFILE): $(DIRPREFIX)/test.header.$(END) sharedtest/$(TESTFILE)
	cat $^ > $@

$(DIR)/test:
	mkdir -p $@

clean:
	git clean -dfx

