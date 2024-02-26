(define-library
  (euphrates olgraph-copy)
  (export olgraph-copy)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/olgraph-copy.scm")))
    (else (include "olgraph-copy.scm"))))
