
(define-library
  (euphrates generic-error-self-key)
  (export generic-error:self-key)
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/generic-error-self-key.scm")))
    (else (include "generic-error-self-key.scm"))))
