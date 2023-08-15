
(define-library
  (euphrates generic-error-irritants-key)
  (export generic-error:irritants-key)
  (import
    (only (euphrates make-unique) make-unique))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/generic-error-irritants-key.scm")))
    (else (include "generic-error-irritants-key.scm"))))
