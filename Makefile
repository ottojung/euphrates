
rebuild: | clean-czempak run

clean-czempak:
	rm -rf .czempak-cache "$(HOME)/.local/share/czempak"

run:
	echo '(environment ((COMPILER "guile"))) !' | czempak run test/main.scm
