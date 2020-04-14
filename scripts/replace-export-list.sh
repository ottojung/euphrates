#! /bin/sh

set -ex

FILE="guile/euphrates/common.scm"

LINENO=$(awk '/EUPHRATES_GUILE_EXPORT_LIST/ {print FNR}' "$FILE")
LEN=$(cat "$FILE" | wc -l)

OUT=$(tempfile)

head -n "$((LINENO - 1))" "$FILE" > "$OUT"
scripts/get-definitions/run.sh >> "$OUT"
tail -n "$((LEN - LINENO))" "$FILE" >> "$OUT"

cp "$OUT" "$FILE"

