
(define-library
  (euphrates generic-error-message-key)
  (export generic-error:message-key)
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/generic-error-message-key.scm")))
    (else (include "generic-error-message-key.scm"))))
