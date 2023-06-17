
(define-library
  (euphrates dprint-p-default)
  (export dprint/p-default)
  (import (only (euphrates printf) printf))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dprint-p-default.scm")))
    (else (include "dprint-p-default.scm"))))
