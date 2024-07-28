
(define-library
  (euphrates bnf-alist-epsilon)
  (export bnf:epsilon)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-epsilon.scm")))
    (else (include "bnf-alist-epsilon.scm"))))
