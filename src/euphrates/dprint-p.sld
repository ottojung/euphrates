
(define-library
  (euphrates dprint-p)
  (export dprint/p)
  (import
    (only (euphrates dprint-p-default)
          dprint/p-default)
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/dprint-p.scm")))
    (else (include "dprint-p.scm"))))
