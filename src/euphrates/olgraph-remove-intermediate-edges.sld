
(define-library
  (euphrates olgraph-remove-intermediate-edges)
  (export
    olnode-remove-intermediate-edges
    olgraph-remove-intermediate-edges)
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!))
  (import (only (euphrates hashset) hashset-has?))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import (only (euphrates negate) negate))
  (import
    (only (euphrates olgraph-remove-edges-generic)
          olgraph-remove-edges/generic
          olnode-remove-edges/generic))
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
          map
          not
          or
          quote))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olgraph-remove-intermediate-edges.scm")))
    (else (include "olgraph-remove-intermediate-edges.scm"))))
