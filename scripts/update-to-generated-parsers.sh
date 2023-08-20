#! /bin/sh

guile --r7rs -L src -L test \
      -s "test/test-lalr-parser-output-precise.sld"

guile --r7rs -L src \
      -s "scripts/update-to-generated-parsers.scm"
