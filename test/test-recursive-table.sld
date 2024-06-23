
(define-library
  (test-recursive-table)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates recursive-table-get)
          recursive-table:get))
  (import
    (only (euphrates recursive-table)
          recursive-table))
  (import
    (only (scheme base)
          +
          begin
          define
          let
          list
          quasiquote
          quote
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-recursive-table.scm")))
    (else (include "test-recursive-table.scm"))))
