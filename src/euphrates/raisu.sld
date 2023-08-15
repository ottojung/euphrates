
(define-library
  (euphrates raisu)
  (export raisu)
  (import
    (only (euphrates generic-error-irritants-key)
          generic-error:irritants-key))
  (import
    (only (euphrates generic-error-type-key)
          generic-error:type-key))
  (import
    (only (euphrates generic-error) generic-error))
  (import
    (only (scheme base) begin cons define list))
  (cond-expand
    (guile (import (only (guile) include-from-path throw))
           (begin (include-from-path "euphrates/raisu.scm")))
    (else (include "raisu.scm"))))
