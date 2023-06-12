
(define-library
  (euphrates open-cond-obj)
  (export
    open-cond-constructor
    open-cond-predicate
    open-cond-value
    set-open-cond-value!)
  (import
    (only (euphrates define-type9) define-type9)
    (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/open-cond-obj.scm")))
    (else (include "open-cond-obj.scm"))))
