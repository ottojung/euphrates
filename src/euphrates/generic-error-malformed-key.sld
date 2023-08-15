
(define-library
  (euphrates generic-error-malformed-key)
  (export generic-error:malformed-key)
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/generic-error-malformed-key.scm")))
    (else (include "generic-error-malformed-key.scm"))))
