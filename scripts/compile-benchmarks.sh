#! /bin/sh

make build

COMPILE="guild compile --r7rs -L $PWD/src -L $PWD/test"
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

	$COMPILE "$FILE"
done
