
(define-library
  (euphrates bnf-alist-left-recursion)
  (export
    bnf-alist:left-recursion:make
    bnf-alist:left-recursion?
    bnf-alist:left-recursion:nonterminal
    bnf-alist:left-recursion:cycle)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-left-recursion.scm")))
    (else (include "bnf-alist-left-recursion.scm"))))
