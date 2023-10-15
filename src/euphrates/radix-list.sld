
(define-library
  (euphrates radix-list)
  (export
    radix-list->number
    number->radix-list
    number->radix-list:precision/p
    radix-list->radix-list)
  (import (only (euphrates fp) fp))
  (import
    (only (scheme base)
          *
          +
          -
          /
          begin
          car
          cdr
          cons
          define
          define-values
          floor
          if
          let
          make-parameter
          null?
          or
          quote
          quotient
          remainder
          reverse
          values
          zero?))
  (import (only (scheme r5rs) inexact->exact))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/radix-list.scm")))
    (else (include "radix-list.scm"))))
