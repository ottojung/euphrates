
(define-library
  (euphrates labelinglogic-expression-interpret-r7rs)
  (export labelinglogic:expression:interpret/r7rs)
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
          quote))
  (import (only (scheme eval) environment eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-interpret-r7rs.scm")))
    (else (include
            "labelinglogic-expression-interpret-r7rs.scm"))))
