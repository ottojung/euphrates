
(define-library
  (euphrates
    labelinglogic-expression-evaluate-r7rs)
  (export labelinglogic:expression:evaluate/r7rs)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (scheme base)
          begin
          car
          define
          lambda
          let
          list
          quote))
  (import (only (scheme eval) environment eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-evaluate-r7rs.scm")))
    (else (include
            "labelinglogic-expression-evaluate-r7rs.scm"))))
