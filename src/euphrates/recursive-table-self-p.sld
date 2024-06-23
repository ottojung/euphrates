
(define-library
  (euphrates recursive-table-self-p)
  (export recursive-table/self/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/recursive-table-self-p.scm")))
    (else (include "recursive-table-self-p.scm"))))
