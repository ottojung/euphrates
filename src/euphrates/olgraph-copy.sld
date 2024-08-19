
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
          olgraph:initial
          olnode:children
          olnode:children:set!
          olnode:copy
          olnode:id))
  (import
    (only (scheme base) begin define let map or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/olgraph-copy.scm")))
    (else (include "olgraph-copy.scm"))))
