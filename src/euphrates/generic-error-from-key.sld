
(define-library
  (euphrates generic-error-from-key)
  (export generic-error:from-key)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/generic-error-from-key.scm")))
    (else (include "generic-error-from-key.scm"))))
