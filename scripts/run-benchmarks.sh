#! /bin/sh

set -e

GUILE="guile --r7rs -L $PWD/src -L $PWD/test"
FILES=$(ls "$PWD/test/benchmark-"*".sld")
TESTCOUNT=$(echo "$FILES" | wc -l)
INDEX=0

mkdir -p dist/benchmarks
cd dist/benchmarks

for FILE in $FILES
do
	INDEX=$((INDEX + 1))
	SHORT="$(basename "$FILE")"

	printf '(%s/%s)' "$INDEX" "$TESTCOUNT"
	printf ' %s\n' "$SHORT"

	$GUILE -s "$FILE"
done
