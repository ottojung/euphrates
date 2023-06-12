
(define-library
  (euphrates profun-variable-arity-op)
  (export profun-variable-arity-op)
  (import
    (only (euphrates profun-op) make-profun-op)
    (only (euphrates profun-variable-arity-op-keyword)
          profun-variable-arity-op-keyword)
    (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-variable-arity-op.scm")))
    (else (include "profun-variable-arity-op.scm"))))
