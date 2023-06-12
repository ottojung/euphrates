
(define-library
  (euphrates profun-op-false)
  (export profun-op-false)
  (import
    (only (euphrates profun-op) make-profun-op)
    (only (euphrates profun-reject) profun-reject)
    (only (scheme base) _ begin define lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-false.scm")))
    (else (include "profun-op-false.scm"))))
