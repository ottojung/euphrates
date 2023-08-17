
(define-library
  (euphrates ebnf-tree-to-alist)
  (export ebnf-tree->alist)
  (import
    (only (euphrates generic-ebnf-tree-to-alist)
          generic-ebnf-tree->alist))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/ebnf-tree-to-alist.scm")))
    (else (include "ebnf-tree-to-alist.scm"))))
