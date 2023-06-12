
TARGET = test/test-compilation.sld
GUILE = guile --r7rs -L $(PWD)/src -L $(PWD)/test -s

all: test

build: compile

test: build
	sh scripts/run-tests.sh

compile:
	sh scripts/make-test-compilation.sh || true
	$(MAKE) one TARGET=test/test-compilation.sld

one:
	$(GUILE) $(TARGET)

cleanrun: | clean one

clean:
	git submodule foreach --recursive 'git clean -dfx'
	git clean -dfx

.PHONY: all test compile one cleanrun clean
