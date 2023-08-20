#! /bin/sh

guile --r7rs -L src \
      -s "scripts/update-to-generated-parsers.scm"
