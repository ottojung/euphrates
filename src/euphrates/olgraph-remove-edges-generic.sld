(define-library
  (euphrates olgraph-remove-edges-generic)
  (export olgraph-remove-edges/generic)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olgraph-remove-edges-generic.scm")))
    (else (include "olgraph-remove-edges-generic.scm"))))
