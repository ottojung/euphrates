
(define-library
  (test-bnf-tree-to-alist)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates bnf-tree-to-alist)
          bnf-tree->alist))
  (import
    (only (euphrates ebnf-tree-to-alist)
          ebnf-tree->alist))
  (import (only (scheme base) / = begin quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-bnf-tree-to-alist.scm")))
    (else (include "test-bnf-tree-to-alist.scm"))))
