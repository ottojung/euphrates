
(define-library
  (euphrates profun-op)
  (export make-profun-op)
  (import
    (only (euphrates profun-op-obj)
          profun-op-constructor))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/profun-op.scm")))
    (else (include "profun-op.scm"))))
