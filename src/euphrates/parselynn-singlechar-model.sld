
(define-library
  (euphrates parselynn-singlechar-model)
  (export parselynn-singlechar-model)
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
             (include-from-path
               "euphrates/parselynn-singlechar-model.scm")))
    (else (include "parselynn-singlechar-model.scm"))))
