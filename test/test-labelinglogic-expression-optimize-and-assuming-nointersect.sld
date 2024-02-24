
(define-library
  (test-labelinglogic-expression-optimize-and-assuming-nointersect)
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-labelinglogic-expression-optimize-and-assuming-nointersect.scm")))
    (else (include
            "test-labelinglogic-expression-optimize-and-assuming-nointersect.scm"))))
