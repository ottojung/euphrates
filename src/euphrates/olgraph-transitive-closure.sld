(define-library
  (euphrates olgraph-transitive-closure)
  (export olgraph-transitive-closure)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olgraph-transitive-closure.scm")))
    (else (include "olgraph-transitive-closure.scm"))))
