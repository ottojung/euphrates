
run:
	echo '' | czempak run test/main.scm

cleanrun: | clean-czempak run run-inlined

clean-czempak:
	rm -rf .czempak-cache "$(HOME)/.local/share/czempak"

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
	time sh -c "echo '' | czempak build test/main.scm"
