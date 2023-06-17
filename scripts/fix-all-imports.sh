#! /bin/sh

for FILE in src/euphrates/*.sld
do
    my-fix-imports "$FILE"
done

sh scripts/revert-import-fixes.sh
