
(define-library
  (euphrates olgraph-remove-transitive-edges)
  (export olnode-remove-transitive-edges)
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-has?
          make-hashset))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import (only (euphrates negate) negate))
  (import
    (only (euphrates olgraph-transitive-closure)
          olnode-transitive-closure/edges))
  (import
    (only (euphrates olgraph)
          make-olnode
          make-olnode/full
          olnode:children
          olnode:children:set!
          olnode:id
          olnode:meta
          olnode:value))
  (import
    (only (euphrates olnode-eq-huh) olnode-eq?))
  (import
    (only (scheme base)
          and
          begin
          cons
          define
          lambda
          let
          not
          quote
          unless))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olgraph-remove-transitive-edges.scm")))
    (else (include "olgraph-remove-transitive-edges.scm"))))
