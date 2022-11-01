#! /bin/sh

for FILE in test/test-*.scm
do
	printf "> %s ..." "$(basename "$FILE")"

	if build/czempak run "$FILE" 2>&1
	then printf " ✓"
	else printf " X"
	fi | grep -v -e '^;;; '
done
