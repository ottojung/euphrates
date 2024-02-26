
(define-library
  (euphrates olgraph-remove-transitive-edges)
  (export olnode-remove-transitive-edges)
  (import
    (only (euphrates olgraph-transitive-closure)
          olnode-transitive-closure/edges))
  (import
    (only (euphrates olgraph)
          make-olnode
          make-olnode/full
          olnode:children
          olnode:meta
          olnode:value))
  (import (only (scheme base) begin define let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olgraph-remove-transitive-edges.scm")))
    (else (include "olgraph-remove-transitive-edges.scm"))))
