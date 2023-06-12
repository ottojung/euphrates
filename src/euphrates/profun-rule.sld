
(define-library
  (euphrates profun-rule)
  (export
    profun-rule-constructor
    profun-rule?
    profun-rule-name
    profun-rule-index
    profun-rule-args
    profun-rule-body)
  (import
    (only (euphrates define-type9) define-type9)
    (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/profun-rule.scm")))
    (else (include "profun-rule.scm"))))
