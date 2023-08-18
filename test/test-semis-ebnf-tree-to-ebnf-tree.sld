
(define-library
  (test-semis-ebnf-tree-to-ebnf-tree)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates semis-ebnf-tree-to-ebnf-tree)
          semis-ebnf-tree->ebnf-tree))
  (import
    (only (scheme base) * + / begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-semis-ebnf-tree-to-ebnf-tree.scm")))
    (else (include "test-semis-ebnf-tree-to-ebnf-tree.scm"))))
