#! /bin/sh

if ! command -v my-fix-imports 1>/dev/null 2>/dev/null
then
	echo "Expect 'my-fix-imports- command to be available." 1>&2
	exit 1
fi

#
# Do not compile the super large, generated files.
#
TMPDIR="$(mktemp -d)"
mv -- test/data/*large* "$TMPDIR"

my-fix-imports \
	--import-everything \
	"test/test-compilation.scm"

mv -- "$TMPDIR"/* test/data/
