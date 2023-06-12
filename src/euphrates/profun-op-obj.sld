
(define-library
  (euphrates profun-op-obj)
  (export
    profun-op-constructor
    profun-op?
    profun-op-arity
    profun-op-procedure)
  (import
    (only (euphrates define-type9) define-type9)
    (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/profun-op-obj.scm")))
    (else (include "profun-op-obj.scm"))))
