(define-library
  (euphrates
    labelinglogic-expression-simplify-ground-terms)
  (export
    labelinglogic:expression:simplify-ground-terms)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-simplify-ground-terms.scm")))
    (else (include
            "labelinglogic-expression-simplify-ground-terms.scm"))))
