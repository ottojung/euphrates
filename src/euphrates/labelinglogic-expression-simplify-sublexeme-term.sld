
(define-library
  (euphrates
    labelinglogic-expression-simplify-sublexeme-term)
  (export
    labelinglogic:expression:simplify-sublexeme-term)
  (import
    (only (euphrates
            labelinglogic-expression-try-simplify-sublexeme-term)
          labelinglogic:expression:try-simplify-sublexeme-term))
  (import (only (scheme base) begin define or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-simplify-sublexeme-term.scm")))
    (else (include
            "labelinglogic-expression-simplify-sublexeme-term.scm"))))
