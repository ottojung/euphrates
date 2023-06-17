
(define-library
  (euphrates regex-machine)
  (export
    make-regex-machine/full
    make-regex-machine
    make-regex-machine*)
  (import (only (euphrates hashmap) hashmap-set!))
  (import
    (only (euphrates immutable-hashmap)
          immutable-hashmap-foreach
          immutable-hashmap-ref
          immutable-hashmap-set
          make-immutable-hashmap))
  (import
    (only (scheme base)
          *
          +
          =
          _
          and
          begin
          cadr
          call-with-values
          car
          case
          cdr
          cons
          define
          else
          equal?
          if
          lambda
          let
          map
          not
          null?
          or
          pair?
          quasiquote
          quote
          unquote
          values))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (srfi srfi-1) any first)))
    (else (import (only (srfi 1) any first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/regex-machine.scm")))
    (else (include "regex-machine.scm"))))
