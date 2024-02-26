
(define-library
  (euphrates olgraph-transitive-closure)
  (export olnode-transitive-closure/edges)
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
               "euphrates/olgraph-transitive-closure.scm")))
    (else (include "olgraph-transitive-closure.scm"))))
