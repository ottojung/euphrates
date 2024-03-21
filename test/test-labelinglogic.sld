
(define-library
  (test-labelinglogic)
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates labelinglogic-model-check)
          labelinglogic:model:check))
  (import
    (only (scheme base)
          and
          begin
          char?
          define
          lambda
          let
          not
          or
          quasiquote
          quote))
  (import
    (only (scheme char)
          char-alphabetic?
          char-lower-case?
          char-numeric?
          char-upper-case?))
  (cond-expand
    (guile (import (only (srfi srfi-1) any)))
    (else (import (only (srfi 1) any))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-labelinglogic.scm")))
    (else (include "test-labelinglogic.scm"))))
