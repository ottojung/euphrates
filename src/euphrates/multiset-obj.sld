
(define-library
  (euphrates multiset-obj)
  (export
    multiset-constructor
    multiset-predicate
    multiset-value)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/multiset-obj.scm")))
    (else (include "multiset-obj.scm"))))
