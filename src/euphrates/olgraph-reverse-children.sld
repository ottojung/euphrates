(define-library
  (euphrates olgraph-reverse-children)
  (export olgraph-reverse-children)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olgraph-reverse-children.scm")))
    (else (include "olgraph-reverse-children.scm"))))
