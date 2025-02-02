
(define-library
  (euphrates bnf-alist-leaf-huh)
  (export bnf-alist:leaf?)
  (import
    (only (euphrates unique-identifier)
          unique-identifier?))
  (import
    (only (scheme base) begin define or symbol?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-leaf-huh.scm")))
    (else (include "bnf-alist-leaf-huh.scm"))))
