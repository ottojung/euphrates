
(define-library
  (euphrates olgraph-copy)
  (export olgraph-copy/deep olnode-copy/deep)
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates olgraph)
          make-olgraph
          make-olnode/full
          olgraph:initial
          olnode:children
          olnode:children:set!
          olnode:id
          olnode:meta
          olnode:value))
  (import
    (only (scheme base)
          begin
          define
          let
          map
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/olgraph-copy.scm")))
    (else (include "olgraph-copy.scm"))))
