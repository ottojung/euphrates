#! /bin/sh

set -e

REVISION=$(git rev-parse HEAD)
TITLE="$(git log -n 1 --format=%s)"
DIR="dist/benchmarks/$REVISION"
GUILE="guile --r7rs -L $PWD/src -L $PWD/test"
FILES=$(ls "$PWD/test/benchmark-"*".sld")
TESTCOUNT=$(echo "$FILES" | wc -l)
INDEX=0

mkdir -p "$DIR"
cd "$DIR"
echo > "info.ini"
echo "title = $TITLE" >> "info.ini"

for FILE in $FILES
do
	INDEX=$((INDEX + 1))
	SHORT="$(basename "$FILE")"

	printf '(%s/%s)' "$INDEX" "$TESTCOUNT"
	printf ' %s\n' "$SHORT"

	$GUILE -s "$FILE"
done
