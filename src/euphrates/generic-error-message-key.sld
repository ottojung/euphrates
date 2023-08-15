
(define-library
  (euphrates generic-error-message-key)
  (export generic-error:message-key)
  (import
    (only (euphrates make-unique) make-unique))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/generic-error-message-key.scm")))
    (else (include "generic-error-message-key.scm"))))
