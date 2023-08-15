
(define-library
  (euphrates generic-error-malformed-key)
  (export generic-error:malformed-key)
  (import
    (only (euphrates make-unique) make-unique))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/generic-error-malformed-key.scm")))
    (else (include "generic-error-malformed-key.scm"))))
