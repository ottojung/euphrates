
(define-library
  (test-list->tree)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates list-to-tree) list->tree)
    (only (euphrates string-to-words) string->words)
    (only (scheme base)
          <
          >
          begin
          cond
          define
          else
          equal?
          let
          list
          map
          quote
          string->symbol
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-list->tree.scm")))
    (else (include "test-list->tree.scm"))))
