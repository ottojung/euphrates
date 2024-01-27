
(define-library
  (test-labelinglogic)
  (import (only (euphrates dprintln) dprintln))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-labelinglogic.scm")))
    (else (include "test-labelinglogic.scm"))))
