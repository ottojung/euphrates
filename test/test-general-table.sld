
(define-library
  (test-general-table)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates general-table) general-table))
  (import
    (only (scheme base)
          +
          begin
          cond-expand
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
