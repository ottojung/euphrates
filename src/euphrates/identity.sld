
(define-library
  (euphrates identity)
  (export identity)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/identity.scm")))
    (else (include "identity.scm"))))
