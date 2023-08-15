
(define-library
  (euphrates generic-error-type-key)
  (export generic-error:type-key)
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/generic-error-type-key.scm")))
    (else (include "generic-error-type-key.scm"))))
