
(define-library
  (euphrates generic-error-irritants-key)
  (export generic-error:irritants-key)
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/generic-error-irritants-key.scm")))
    (else (include "generic-error-irritants-key.scm"))))
