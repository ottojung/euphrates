
(define-library
  (euphrates olgraph-remove-edges-generic)
  (export
    olgraph-remove-edges/generic
    olnode-remove-edges/generic)
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import (only (euphrates hashset) hashset-has?))
  (import
    (only (euphrates olgraph-transitive-closure)
          olnode-transitive-closure/edges))
  (import
    (only (euphrates olgraph)
          make-olgraph
          make-olnode
          olgraph:initial
          olnode:children
          olnode:children:set!
          olnode:copy
          olnode:id
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
          or))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olgraph-remove-edges-generic.scm")))
    (else (include "olgraph-remove-edges-generic.scm"))))
