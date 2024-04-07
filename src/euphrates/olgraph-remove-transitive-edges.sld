
(define-library
  (euphrates olgraph-remove-transitive-edges)
  (export olgraph-remove-transitive-edges)
  (import (only (euphrates hashset) hashset-has?))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (euphrates olgraph-remove-edges-generic)
          olgraph-remove-edges/generic
          olnode-remove-edges/generic))
  (import (only (euphrates olgraph) olnode:id))
  (import
    (only (euphrates olnode-eq-huh) olnode-eq?))
  (import
    (only (scheme base)
          begin
          cons
          define
          lambda
          let
          not
          or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olgraph-remove-transitive-edges.scm")))
    (else (include "olgraph-remove-transitive-edges.scm"))))
