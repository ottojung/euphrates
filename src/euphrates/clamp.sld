
(define-library
  (euphrates clamp)
  (export clamp)
  (import
    (only (scheme base) begin define max min))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "euphrates/clamp.scm")))
    (else (include "clamp.scm"))))
