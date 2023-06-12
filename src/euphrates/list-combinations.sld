
(define-library
  (euphrates list-combinations)
  (export list-combinations)
  (import
    (only (euphrates list-fold) list-fold)
    (only (scheme base)
          +
          -
          <
          <=
          =
          >
          >=
          begin
          cond
          cons
          define
          define-values
          else
          expt
          if
          lambda
          let
          let*
          list->vector
          make-vector
          max
          not
          quote
          quotient
          set!
          values
          vector-length
          vector-ref
          vector-set!
          when
          zero?)
    (only (scheme case-lambda) case-lambda)
    (only (srfi srfi-1) first last)
    (only (srfi srfi-60)
          arithmetic-shift
          bit-set?
          bitwise-and
          bitwise-xor))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-combinations.scm")))
    (else (include "list-combinations.scm"))))
