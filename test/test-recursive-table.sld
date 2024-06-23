
(define-library
  (test-recursive-table)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates recursive-table-self-p)
          recursive-table/self/p))
  (import
    (only (euphrates recursive-table)
          recursive-table))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          +
          _
          begin
          cadr
          car
          define
          define-syntax
          equal?
          lambda
          let
          list
          null?
          or
          quasiquote
          quote
          syntax-rules
          unquote
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-recursive-table.scm")))
    (else (include "test-recursive-table.scm"))))
