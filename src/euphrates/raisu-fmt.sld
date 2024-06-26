
(define-library
  (euphrates raisu-fmt)
  (export raisu-fmt)
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base) apply begin cons define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/raisu-fmt.scm")))
    (else (include "raisu-fmt.scm"))))
