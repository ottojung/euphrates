
INSTALL_LIST += $(shell hash guile || echo install-guile)
INSTALL_LIST += $(shell hash racket || echo install-racket)

TESTFILES = main.scm comprocess.scm tree-future.scm tree-future-cancel.scm tree-future-context.scm
TESTS = $(shell echo " $(TESTFILES)" | sed 's/ / test-/g')

dependencies: $(INSTALL_LIST)

install-guile:
	apt-get install -y guile-2.2

install-racket:
	apt-get install -y racket

build-all:
	$(MAKE) all

install-all:
	sudo $(MAKE) install

testall:
	$(MAKE) $(TESTS) BACKEND=guile -f makefiles/ci.make
	$(MAKE) $(TESTS) BACKEND=racket -f makefiles/ci.make

test-%:
	$(BACKEND) build/test/src/$(BACKEND)/$(shell echo $@ | sed 's/test-//g')

.ONESHELL: $(TESTS)

