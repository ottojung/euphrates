
(define-library
  (euphrates olgraph)
  (export
    make-olgraph
    olgraph:id
    olgraph:value
    olgraph:children
    olgraph:children:set!
    olgraph:meta
    olgraph:meta:set!)
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (scheme base)
          +
          begin
          define
          lambda
          let
          set!))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/olgraph.scm")))
    (else (include "olgraph.scm"))))
