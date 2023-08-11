
TARGET = test/test-compilation.sld
GUILE = guile --r7rs -L $(PWD)/src -L $(PWD)/test -s

all: build

build: compile

test: compilation-test
	sh scripts/run-tests.sh

compile: compilation-test
	$(MAKE) one TARGET=test/test-compilation.sld

compilation-test:
	sh scripts/make-test-compilation.sh || true

one:
	$(GUILE) $(TARGET)

cleanrun: | clean one

clean:
	true

.PHONY: all test compile compilation-test one cleanrun clean
