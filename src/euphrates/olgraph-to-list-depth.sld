(define-library
  (euphrates olgraph-to-list-depth)
  (export olgraph->list/depth)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olgraph-to-list-depth.scm")))
    (else (include "olgraph-to-list-depth.scm"))))
