
(define-library
  (euphrates
    labelinglogic-expression-to-simplified-mod2-expression)
  (export
    labelinglogic:expression->simplified-mod2-expression)
  (import
    (only (euphrates labelinglogic-expression-sugarify)
          labelinglogic:expression:sugarify))
  (import
    (only (euphrates
            labelinglogic-expression-to-mod2-expression)
          labelinglogic:expression->mod2-expression))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-to-simplified-mod2-expression.scm")))
    (else (include
            "labelinglogic-expression-to-simplified-mod2-expression.scm"))))
