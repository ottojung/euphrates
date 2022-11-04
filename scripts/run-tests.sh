#! /bin/sh

set -e

TESTCOUNT=$(ls test/test-*.scm | wc -l)
INDEX=0

for FILE in test/test-*.scm
do
	INDEX=$((INDEX + 1))
	SHORT="$(basename "$FILE")"
	SHORTLEN=$(echo "$SHORT" | wc -c)

	printf '(%s/%s)' "$INDEX" "$TESTCOUNT"
	printf ' %s ... ' "$SHORT"

	if build/czempak run "$FILE" 2>&1
	then printf '✓'
	else printf 'X'
	fi | grep -v -e '^;;; '
done
