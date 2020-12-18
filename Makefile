
rebuild: | clean-czempak run

clean-czempak:
	rm -rf .czempak-cache "$(HOME)/.local/share/czempak"

run:
	echo '(environment ((COMPILER "guile"))) !' | czempak run test/main.scm

time: | clean-czempak time-build

time-build:
	time sh -c "echo '(environment ((COMPILER \"guile\"))) !' | czempak build test/main.scm"
