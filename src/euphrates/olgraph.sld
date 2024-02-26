
(define-library
  (euphrates olgraph)
  (export
    make-olgraph
    olgraph?
    olgraph:roots
    make-olnode
    olnode?
    olnode:id
    olnode:value
    olnode:children
    olnode:children:set!
    olnode:meta
    olnode:meta:set!)
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
