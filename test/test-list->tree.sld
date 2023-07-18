
(define-library
  (test-list->tree)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-to-tree) list->tree))
  (import
    (only (euphrates string-to-words) string->words))
  (import
    (only (scheme base)
          <
          >
          begin
          cond
          cond-expand
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
