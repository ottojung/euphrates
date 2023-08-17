
(define-library
  (euphrates generic-error-kind-key)
  (export generic-error:kind-key)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/generic-error-kind-key.scm")))
    (else (include "generic-error-kind-key.scm"))))
