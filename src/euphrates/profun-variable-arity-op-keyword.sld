
(define-library
  (euphrates profun-variable-arity-op-keyword)
  (export profun-variable-arity-op-keyword)
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-variable-arity-op-keyword.scm")))
    (else (include "profun-variable-arity-op-keyword.scm"))))
