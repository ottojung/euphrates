
(define-library
  (euphrates bnf-alist-end-of-input)
  (export bnf:end-of-input)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-end-of-input.scm")))
    (else (include "bnf-alist-end-of-input.scm"))))
