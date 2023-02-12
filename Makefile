
TARGET = test/main.scm
GUILE = guile -L $(PWD)/src -s

all: compile
	sh scripts/run-tests.sh

compile:
	sh scripts/make-test-compilation.sh
	$(MAKE) one TARGET=test/test-compilation.scm

one:
	$(GUILE) $(TARGET)

cleanrun: | clean one

clean:
	git submodule foreach --recursive 'git clean -dfx'
	git clean -dfx
