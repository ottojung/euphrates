#! /bin/sh

TESTCOUNT=$(ls test/test-*.scm | wc -l)
INDEX=0

for FILE in test/test-*.scm
do
	INDEX=$((INDEX + 1))
	SHORT="$(basename "$FILE")"
	SHORTLEN=$(echo "$SHORT" | wc -c)

	LEFT=$((40 - SHORTLEN))
	if test "$LEFT" -lt 0
	then LEFT=0
	fi

	# printf '%0.s-' $(seq 1 $LEFT)
	printf '(%s/%s)' "$INDEX" "$TESTCOUNT"
	printf ' %s ... ' "$SHORT"

	if build/czempak run "$FILE" 2>&1
	then printf '✓'
	else printf 'X'
	fi | grep -v -e '^;;; '
done
