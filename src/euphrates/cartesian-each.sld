
(define-library
  (euphrates cartesian-each)
  (export cartesian-each)
  (import
    (only (scheme base)
          begin
          car
          cdr
          define
          let
          null?
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/cartesian-each.scm")))
    (else (include "cartesian-each.scm"))))
