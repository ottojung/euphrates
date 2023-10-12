
(define-library
  (test-labelinglogic)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates char-nocase-alphabetic-huh)
          char-nocase-alphabetic?))
  (import
    (only (euphrates labelinglogic)
          make-labelinglogic))
  (import
    (only (scheme base)
          =
          and
          begin
          define
          lambda
          let
          not
          quasiquote
          quote
          unquote))
  (import
    (only (scheme char)
          char-alphabetic?
          char-lower-case?
          char-numeric?
          char-upper-case?
          char-whitespace?))
  (cond-expand
    (guile (import (only (srfi srfi-1) any)))
    (else (import (only (srfi 1) any))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-labelinglogic.scm")))
    (else (include "test-labelinglogic.scm"))))
