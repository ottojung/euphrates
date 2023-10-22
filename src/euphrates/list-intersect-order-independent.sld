
(define-library
  (euphrates list-intersect-order-independent)
  (export list-intersect/order-independent)
  (import
    (only (scheme base)
          begin
          car
          cdr
          cons
          define
          if
          let
          member
          null?
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-intersect-order-independent.scm")))
    (else (include "list-intersect-order-independent.scm"))))
