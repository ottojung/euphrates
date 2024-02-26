
(define-library
  (euphrates olgraph)
  (export
    make-olgraph
    olgraph:id
    olgraph:value
    olgraph:children
    olgraph:children:set!
    olgraph:meta
    olgraph:meta:set!
    olgraph-eq?)
  (import
    (only (scheme base)
          +
          begin
          define
          define-record-type
          lambda
          let
          set!))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/olgraph.scm")))
    (else (include "olgraph.scm"))))
