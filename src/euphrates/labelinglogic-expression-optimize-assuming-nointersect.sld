(define-library
  (euphrates
    labelinglogic-expression-optimize-assuming-nointersect)
  (export
    labelinglogic:expression:optimize/assuming-nointersect)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-optimize-assuming-nointersect.scm")))
    (else (include
            "labelinglogic-expression-optimize-assuming-nointersect.scm"))))
