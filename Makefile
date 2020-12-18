
rebuild:
	rm -rf .czempak-cache "$(HOME)/.local/share/czempak"
	echo '(environment ((COMPILER "guile"))) !' | czempak run test/main.scm
