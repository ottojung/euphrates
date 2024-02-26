
(define-library
  (euphrates olgraph-to-adjlist)
  (export olnode->adjlist)
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-has?
          make-hashset))
  (import
    (only (euphrates olgraph)
          olnode:children
          olnode:id))
  (import
    (only (scheme base)
          begin
          cons
          define
          for-each
          lambda
          let
          list
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olgraph-to-adjlist.scm")))
    (else (include "olgraph-to-adjlist.scm"))))
