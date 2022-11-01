
SUBMODULES = deps/czempak/.git
TARGET=test/main.scm
CZEMPAK_ROOT = $(PWD)/.czempak-root
CZEMPAK = CZEMPAK_ROOT=$(CZEMPAK_ROOT) ./build/czempak

compile:
	sh scripts/make-test-compilation.sh
	$(MAKE) one TARGET=test/test-compilation.scm

all: build/czempak
	CZEMPAK_ROOT=$(PWD)/.czempak-root sh scripts/run-tests.sh

one: build/czempak
	$(CZEMPAK) run $(TARGET)

cleanrun: | clean run run-inlined

clean:
	git submodule foreach --recursive 'git clean -dfx'
	git clean -dfx

clean-czempak:
	rm -rf $(PWD)/.czempak-root

run-inlined:
	echo '(inlined-dest inlined) ?' | \
		$(CZEMPAK) build test/main.scm | \
		guile -c '(load (cdr (car (read))))'

get-inlined:
	echo '(inlined-dest inlined) ?' | \
		$(CZEMPAK) build test/main.scm | \
		guile -c '(display (cdr (car (read))))'

time: | clean-czempak build/czempak
	time sh -c "echo | $(CZEMPAK) build test/main.scm"

build/czempak: $(SUBMODULES) build
	cd deps/czempak && $(MAKE) PREFIXBIN=$(PWD)/build

deps/czempak/.git:
	git submodule update --init
	git submodule foreach --recursive 'git submodule update --init'

build:
	mkdir -p "$@"
