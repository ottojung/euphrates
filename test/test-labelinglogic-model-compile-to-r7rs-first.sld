
(define-library
  (test-labelinglogic-model-compile-to-r7rs-first)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates labelinglogic-interpret-r7rs-code)
          labelinglogic:interpret-r7rs-code))
  (import
    (only (euphrates
            labelinglogic-model-compile-to-r7rs-first)
          labelinglogic:model:compile-to-r7rs/first))
  (import
    (only (euphrates labelinglogic-model-interpret-first)
          labelinglogic:model:interpret/first))
  (import
    (only (scheme base)
          =
          _
          and
          begin
          char?
          cond
          define
          define-syntax
          else
          equal?
          lambda
          let
          map
          not
          or
          quote
          string->list
          syntax-rules
          unless))
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
               "test-labelinglogic-model-compile-to-r7rs-first.scm")))
    (else (include
            "test-labelinglogic-model-compile-to-r7rs-first.scm"))))
