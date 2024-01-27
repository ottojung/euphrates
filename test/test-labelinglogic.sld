
(define-library
  (test-labelinglogic)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates dprintln) dprintln))
  (import
    (only (scheme base)
          and
          begin
          boolean?
          car
          cdr
          cond
          define
          else
          eq?
          error
          if
          lambda
          let
          map
          member
          not
          null?
          or
          pair?
          quasiquote
          quote
          symbol?
          unquote
          unquote-splicing))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-labelinglogic.scm")))
    (else (include "test-labelinglogic.scm"))))
