
(define-library
  (euphrates olgraph-copy)
  (export olgraph-copy)
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!))
  (import
    (only (euphrates olgraph)
          make-olnode/full
          olnode:children
          olnode:children:set!
          olnode:id
          olnode:meta
          olnode:value))
  (import
    (only (scheme base) begin define let or quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/olgraph-copy.scm")))
    (else (include "olgraph-copy.scm"))))
