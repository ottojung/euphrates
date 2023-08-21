
(define-library
  (euphrates bnf-tree-to-alist)
  (export bnf-tree->alist)
  (import
    (only (euphrates generic-bnf-tree-to-alist)
          generic-bnf-tree->alist))
  (import
    (only (scheme base) / begin define let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-tree-to-alist.scm")))
    (else (include "bnf-tree-to-alist.scm"))))
