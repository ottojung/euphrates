
(define-library
  (test-general-table)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates general-table) general-table)
    (only (scheme base)
          +
          begin
          let
          list
          quasiquote
          quote
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-general-table.scm")))
    (else (include "test-general-table.scm"))))
