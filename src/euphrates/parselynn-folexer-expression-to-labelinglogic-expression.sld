
(define-library
  (euphrates
    parselynn-folexer-expression-to-labelinglogic-expression)
  (export
    parselynn:folexer:expression->labelinglogic:expression)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-folexer-expression-to-labelinglogic-expression.scm")))
    (else (include
            "parselynn-folexer-expression-to-labelinglogic-expression.scm"))))
