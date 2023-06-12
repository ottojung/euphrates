#! /bin/sh

set -e

TESTCOUNT=$(ls test/test-*.sld | wc -l)
INDEX=0

for FILE in test/test-*.sld
do
	INDEX=$((INDEX + 1))
	SHORT="$(basename "$FILE")"
	SHORTLEN=$(echo "$SHORT" | wc -c)

	printf '(%s/%s)' "$INDEX" "$TESTCOUNT"
	printf ' %s ... ' "$SHORT"

	R=$(if guile --r7rs -L "$PWD/src" -L "$PWD/test" -s "$FILE" 2>&1
	then printf '✓'
	else printf 'X'
	fi)

	printf '%s' "$R" | grep -v -e '^;;; ' || true
	printf '%s' "$R" | grep -q -e '✓'
done
