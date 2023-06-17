
(define-library
  (euphrates profun-reject)
  (export profun-reject profun-reject?)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/profun-reject.scm")))
    (else (include "profun-reject.scm"))))
