
(define-library
  (euphrates semis-ebnf-tree-to-ebnf-tree)
  (export semis-ebnf-tree->ebnf-tree)
  (import
    (only (euphrates generic-semis-ebnf-tree-to-ebnf-tree)
          generic-semis-ebnf-tree->ebnf-tree))
  (import
    (only (scheme base) / = begin define let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/semis-ebnf-tree-to-ebnf-tree.scm")))
    (else (include "semis-ebnf-tree-to-ebnf-tree.scm"))))
