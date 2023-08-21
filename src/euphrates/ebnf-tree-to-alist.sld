
(define-library
  (euphrates ebnf-tree-to-alist)
  (export ebnf-tree->alist)
  (import
    (only (euphrates generic-ebnf-tree-to-alist)
          generic-ebnf-tree->alist))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          /
          =
          begin
          car
          define
          lambda
          list
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/ebnf-tree-to-alist.scm")))
    (else (include "ebnf-tree-to-alist.scm"))))
