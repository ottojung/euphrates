
(define-library
  (test-labelinglogic-expression-optimize-assuming-nointerset-dnf)
  (import (only (euphrates debug) debug))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-labelinglogic-expression-optimize-assuming-nointerset-dnf.scm")))
    (else (include
            "test-labelinglogic-expression-optimize-assuming-nointerset-dnf.scm"))))
