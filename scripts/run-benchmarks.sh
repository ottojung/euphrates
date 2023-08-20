#! /bin/sh

set -e

export EUPHRATES_REVISION_ID="$(git rev-parse HEAD)"
export EUPHRATES_REVISION_DATE="$(git log -n 1 --format=%cd --date=iso8601-strict)"
export EUPHRATES_REVISION_TITLE="$(git log -n 1 --format=%s)"

NAMESPACE=$(git log -n 1 --format=%cd --date=iso8601-strict | tr : x)
DIR="dist/benchmarks/$NAMESPACE"
GUILE="guile --r7rs -L $PWD/src -L $PWD/test"
FILES=$(ls "$PWD/test/benchmark-"*".sld")
TESTCOUNT=$(echo "$FILES" | wc -l)
INDEX=0

mkdir -p "$DIR"
cd "$DIR"

for FILE in $FILES
do
	INDEX=$((INDEX + 1))
	SHORT="$(basename "$FILE")"

	printf '(%s/%s)' "$INDEX" "$TESTCOUNT"
	printf ' %s\n' "$SHORT"

	$GUILE -s "$FILE"
done
