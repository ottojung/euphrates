
(define-library
  (euphrates number-list)
  (export
    number-list->number
    number->number-list
    number->number-list:precision/p
    number-list->number-list)
  (import
    (only (euphrates fp) fp)
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
          zero?)
    (only (scheme r5rs) inexact->exact))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/number-list.scm")))
    (else (include "number-list.scm"))))
