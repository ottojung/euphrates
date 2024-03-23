(define-library
  (euphrates
    labelinglogic-expression-optimize-singletons)
  (export
    labelinglogic:expression:optimize/singletons)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-optimize-singletons.scm")))
    (else (include
            "labelinglogic-expression-optimize-singletons.scm"))))
