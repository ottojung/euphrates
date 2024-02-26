(define-library
  (euphrates olgraph-to-adjlist)
  (export olgraph->adjlist)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olgraph-to-adjlist.scm")))
    (else (include "olgraph-to-adjlist.scm"))))
