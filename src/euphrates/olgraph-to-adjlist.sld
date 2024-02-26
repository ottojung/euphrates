
(define-library
  (euphrates olgraph-to-adjlist)
  (export olnode->adjlist)
  (import
    (only (euphrates hashmap)
          hashmap-has?
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates olgraph)
          olnode:children
          olnode:id))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import
    (only (scheme base)
          begin
          define
          for-each
          let
          reverse
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olgraph-to-adjlist.scm")))
    (else (include "olgraph-to-adjlist.scm"))))
