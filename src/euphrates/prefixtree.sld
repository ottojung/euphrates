
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
          list-find-first)
    (only (euphrates prefixtree-obj)
          prefixtree
          prefixtree-children
          prefixtree-value
          set-prefixtree-children!
          set-prefixtree-value!)
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
          vector)
    (only (srfi srfi-31) rec))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/prefixtree.scm")))
    (else (include "prefixtree.scm"))))
