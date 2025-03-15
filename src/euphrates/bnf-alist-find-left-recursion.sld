
(define-library
  (euphrates bnf-alist-find-left-recursion)
  (export bnf-alist:find-left-recursion)
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-find-left-recursion.scm")))
    (else (include "bnf-alist-find-left-recursion.scm"))))
