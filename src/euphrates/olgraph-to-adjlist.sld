
(define-library
  (euphrates olgraph-to-adjlist)
  (export olgraph->adjlist olnode->adjlist)
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-has?
          make-hashset))
  (import
    (only (euphrates olgraph)
          olgraph:initial
          olnode:children
          olnode:id
          olnode:value))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import
    (only (scheme base)
          append
          apply
          begin
          cons
          define
          for-each
          let
          map
          reverse
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olgraph-to-adjlist.scm")))
    (else (include "olgraph-to-adjlist.scm"))))
