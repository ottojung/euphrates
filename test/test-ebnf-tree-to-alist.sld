
(define-library
  (test-ebnf-tree-to-alist)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates ebnf-tree-to-alist)
          ebnf-tree->alist))
  (import
    (only (euphrates generic-ebnf-tree-to-alist)
          generic-ebnf-tree->alist))
  (import
    (only (scheme base) * + / = begin lambda quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-ebnf-tree-to-alist.scm")))
    (else (include "test-ebnf-tree-to-alist.scm"))))
