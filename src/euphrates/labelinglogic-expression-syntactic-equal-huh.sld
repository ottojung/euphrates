
(define-library
  (euphrates
    labelinglogic-expression-syntactic-equal-huh)
  (export
    labelinglogic:expression:syntactic-equal?)
  (import (only (scheme base) begin define equal?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-syntactic-equal-huh.scm")))
    (else (include
            "labelinglogic-expression-syntactic-equal-huh.scm"))))
