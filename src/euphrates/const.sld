
(define-library
  (euphrates const)
  (export const)
  (import
    (only (scheme base) _ begin define lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "euphrates/const.scm")))
    (else (include "const.scm"))))
