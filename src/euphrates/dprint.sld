
(define-library
  (euphrates dprint)
  (export dprint)
  (import (only (euphrates dprint-p) dprint/p))
  (import
    (only (scheme base) apply begin define lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/dprint.scm")))
    (else (include "dprint.scm"))))
