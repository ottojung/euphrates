
(define-library
  (test-labelinglogic-expression-desugar)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates labelinglogic-expression-desugar)
          labelinglogic::expression:desugar))
  (import (only (scheme base) begin let or quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-labelinglogic-expression-desugar.scm")))
    (else (include
            "test-labelinglogic-expression-desugar.scm"))))
