
(define-library
  (euphrates prefixtree)
  (export
    make-prefixtree
    prefixtree-set!
    prefixtree-ref
    prefixtree-ref-closest
    prefixtree-ref-furthest
    prefixtree->tree)
  (import
    (only (euphrates list-find-first)
          list-find-first))
  (import
    (only (euphrates prefixtree-obj)
          prefixtree
          prefixtree-children
          prefixtree-value
          set-prefixtree-children!
          set-prefixtree-value!))
  (import
    (only (scheme base)
          append
          apply
          begin
          car
          cdr
          cons
          define
          eq?
          equal?
          if
          lambda
          let
          let*
          list
          map
          null?
          quote
          vector))
  (cond-expand
    (guile (import (only (srfi srfi-31) rec)))
    (else (import (only (srfi 31) rec))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/prefixtree.scm")))
    (else (include "prefixtree.scm"))))
