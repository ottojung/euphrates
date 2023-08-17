
(define-library
  (euphrates generic-bnf-tree-to-alist)
  (export generic-bnf-tree->alist)
  (import
    (only (euphrates list-length-geq-q)
          list-length=<?))
  (import
    (only (euphrates list-split-on) list-split-on))
  (import (only (euphrates negate) negate))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          begin
          cadr
          car
          cdr
          cons
          define
          equal?
          if
          lambda
          let
          list
          list?
          map
          null?
          quote
          unless
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter last)))
    (else (import (only (srfi 1) filter last))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/generic-bnf-tree-to-alist.scm")))
    (else (include "generic-bnf-tree-to-alist.scm"))))
