#! /bin/sh

export GUILE_AUTO_COMPILE=0

for FILE in test/test-*.scm
do
	printf "> %s ..." "$FILE"

	if build/czempak run "$FILE"
	then printf " ✓"
	else printf " X"
	fi

	echo
done
