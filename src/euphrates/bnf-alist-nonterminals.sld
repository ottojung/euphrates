
(define-library
  (euphrates bnf-alist-nonterminals)
  (export bnf-alist:nonterminals)
  (import
    (only (scheme base) begin car define map))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-nonterminals.scm")))
    (else (include "bnf-alist-nonterminals.scm"))))
