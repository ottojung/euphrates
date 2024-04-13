
(define-library
  (test-labelinglogic-model-compile-to-r7rs-first)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates
            labelinglogic-model-compile-to-r7rs-first)
          labelinglogic:model:compile-to-r7rs/first))
  (import
    (only (scheme base)
          =
          _
          and
          begin
          cond
          define
          define-syntax
          else
          equal?
          lambda
          let
          not
          or
          quote
          syntax-rules
          unless))
  (import
    (only (scheme char)
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