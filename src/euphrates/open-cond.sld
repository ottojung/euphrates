
(define-library
  (euphrates open-cond)
  (export
    define-open-cond
    open-cond?
    define-open-cond-instance
    open-cond-lambda)
  (import
    (only (euphrates open-cond-obj)
          open-cond-constructor
          open-cond-predicate
          open-cond-value
          set-open-cond-value!)
    (only (scheme base)
          _
          and
          apply
          begin
          car
          cdr
          cons
          define
          define-syntax
          if
          lambda
          let
          not
          null?
          or
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/open-cond.scm")))
    (else (include "open-cond.scm"))))
