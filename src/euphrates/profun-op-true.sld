
(define-library
  (euphrates profun-op-true)
  (export profun-op-true)
  (import
    (only (euphrates profun-accept) profun-accept)
    (only (euphrates profun-op) make-profun-op)
    (only (scheme base) _ begin define lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-true.scm")))
    (else (include "profun-op-true.scm"))))
