
(define-library
  (euphrates
    labelinglogic-expression-inline-references)
  (export
    labelinglogic:expression:inline-references)
  (import
    (only (euphrates
            labelinglogic-expression-inline-references-subexpression)
          labelinglogic:expression:inline-references/subexpression))
  (import
    (only (euphrates
            labelinglogic-expression-map-subexpressions)
          labelinglogic:expression:map-subexpressions))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-inline-references.scm")))
    (else (include
            "labelinglogic-expression-inline-references.scm"))))
