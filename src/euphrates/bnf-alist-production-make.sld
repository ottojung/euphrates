
(define-library
  (euphrates bnf-alist-production-make)
  (export bnf-alist:production:make)
  (import (only (scheme base) begin define list))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-production-make.scm")))
    (else (include "bnf-alist-production-make.scm"))))
