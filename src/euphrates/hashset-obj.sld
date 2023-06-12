
(define-library
  (euphrates hashset-obj)
  (export
    hashset-constructor
    hashset-predicate
    hashset-value)
  (import
    (only (euphrates define-type9) define-type9)
    (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/hashset-obj.scm")))
    (else (include "hashset-obj.scm"))))
