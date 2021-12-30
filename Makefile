
run:
	czempak run test/main.scm

cleanrun:
	CZEMPAK_ROOT=.czempak-root $(MAKE) cleanrun-s

cleanrun-s: | clean-czempak run run-inlined

clean-czempak:
	rm -rf .czempak-*

clean:
	git clean -dfx

run-inlined:
	echo '(inlined-dest inlined) ?' | \
		czempak build test/main.scm | \
		guile -c '(load (cdr (car (read))))'

get-inlined:
	echo '(inlined-dest inlined) ?' | \
		czempak build test/main.scm | \
		guile -c '(display (cdr (car (read))))'

time: | clean-czempak time-build

time-build:
	CZEMPAK_ROOT=.czempak-root $(MAKE) time-build-s
time-build-s: clean-czempak
	time sh -c "echo | czempak build test/main.scm"
