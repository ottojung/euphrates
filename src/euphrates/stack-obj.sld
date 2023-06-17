
(define-library
  (euphrates stack-obj)
  (export
    stack-constructor
    stack-predicate
    stack-lst
    set-stack-lst!)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/stack-obj.scm")))
    (else (include "stack-obj.scm"))))
