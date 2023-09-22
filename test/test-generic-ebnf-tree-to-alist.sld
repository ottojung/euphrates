
(define-library
  (test-generic-ebnf-tree-to-alist)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates generic-ebnf-tree-to-alist)
          generic-ebnf-tree->alist))
  (import
    (only (scheme base)
          *
          +
          /
          =
          begin
          define
          lambda
          let
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-generic-ebnf-tree-to-alist.scm")))
    (else (include "test-generic-ebnf-tree-to-alist.scm"))))
