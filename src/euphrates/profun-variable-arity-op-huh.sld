
(define-library
  (euphrates profun-variable-arity-op-huh)
  (export profun-variable-arity-op?)
  (import
    (only (euphrates profun-op-obj) profun-op-arity))
  (import
    (only (euphrates profun-variable-arity-op-keyword)
          profun-variable-arity-op-keyword))
  (import (only (scheme base) begin define equal?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-variable-arity-op-huh.scm")))
    (else (include "profun-variable-arity-op-huh.scm"))))
