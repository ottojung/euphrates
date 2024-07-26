
(define-library
  (euphrates bnf-alist-empty-huh)
  (export bnf-alist:empty?)
  (import (only (scheme base) begin define null?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-empty-huh.scm")))
    (else (include "bnf-alist-empty-huh.scm"))))
