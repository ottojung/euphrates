(define-library
  (euphrates labelinglogic-expression-inline-some)
  (export labelinglogic:expression:inline-some)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-inline-some.scm")))
    (else (include
            "labelinglogic-expression-inline-some.scm"))))
