
INSTALL_LIST += $(shell hash guile || echo install-guile)
INSTALL_LIST += $(shell hash racket || echo install-racket)

TESTFILES = main.scm comprocess.scm tree-future.scm tree-future-cancel.scm tree-future-context.scm
TESTS = $(shell echo " $(TESTFILES)" | sed 's/ / test-/g')

dependencies: $(INSTALL_LIST)

install-guile:
	apt-get update
	apt-get install -y guile-2.2
	guile --version

install-racket:
	apt-get update
	apt-get install -y racket
	racket --version

build-all:
	$(MAKE) all

install-all:
	sudo $(MAKE) install

testall: testguile testracket

quick-test:
	GUILE_AUTO_COMPILE=0 $(MAKE) test-main.scm BACKEND=guile -f makefiles/ci.make

testguile:
	$(MAKE) $(TESTS) BACKEND=guile -f makefiles/ci.make

testracket:
	$(MAKE) $(TESTS) BACKEND=racket -f makefiles/ci.make

test-%: build-all
	$(BACKEND) build/test/src/$(BACKEND)/$(shell echo $@ | sed 's/test-//g')

