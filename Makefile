
testall: | clean-czempak run run-inlined

clean-czempak:
	rm -rf .czempak-cache "$(HOME)/.local/share/czempak"

run:
	echo '(environment ((COMPILER "guile"))) !' | czempak run test/main.scm

run-inlined:
	echo '(environment ((COMPILER "guile"))) ! (inlined-dest inlined) ?' | \
		czempak build test/main.scm | \
		guile -c '(load (cdr (car (read))))'

get-inlined:
	echo '(environment ((COMPILER "guile"))) ! (inlined-dest inlined) ?' | \
		czempak build test/main.scm | \
		guile -c '(display (cdr (car (read))))'

time: | clean-czempak time-build

time-build:
	time sh -c "echo '(environment ((COMPILER \"guile\"))) !' | czempak build test/main.scm"
