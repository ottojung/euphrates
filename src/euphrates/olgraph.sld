
(define-library
  (euphrates olgraph)
  (export
    make-olgraph
    olgraph?
    olgraph:initial
    olgraph:initial:set!
    olgraph:prepend-initial!
    make-olnode
    make-olnode/full
    olnode?
    olnode:id
    olnode:value
    olnode:children
    olnode:children:set!
    olnode:meta
    olnode:meta:set!
    olnode:prepend-child!)
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (scheme base)
          +
          begin
          cons
          define
          lambda
          let
          quote
          set!))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/olgraph.scm")))
    (else (include "olgraph.scm"))))
