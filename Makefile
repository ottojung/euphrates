
SUBMODULES = deps/czempak/.git

CZEMPAK = CZEMPAK_ROOT=$(PWD)/.czempak-root ./build/czempak

run: build/czempak
	$(CZEMPAK) run test/main.scm

all: build/czempak
	$(CZEMPAK) build test/main.scm

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
