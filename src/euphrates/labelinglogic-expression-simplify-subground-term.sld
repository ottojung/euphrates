
(define-library
  (euphrates
    labelinglogic-expression-simplify-subground-term)
  (export
    labelinglogic:expression:simplify-subground-term)
  (import
    (only (euphrates
            labelinglogic-expression-try-simplify-subground-term)
          labelinglogic:expression:try-simplify-subground-term))
  (import (only (scheme base) begin define or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-simplify-subground-term.scm")))
    (else (include
            "labelinglogic-expression-simplify-subground-term.scm"))))
