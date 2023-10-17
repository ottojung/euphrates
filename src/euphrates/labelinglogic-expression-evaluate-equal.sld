
(define-library
  (euphrates
    labelinglogic-expression-evaluate-equal)
  (export labelinglogic:expression:evaluate/equal)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (scheme base) begin car define equal?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-evaluate-equal.scm")))
    (else (include
            "labelinglogic-expression-evaluate-equal.scm"))))
