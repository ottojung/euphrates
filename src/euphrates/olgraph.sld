
(define-library
  (euphrates olgraph)
  (export
    make-olgraph
    olgraph?
    olgraph:initial
    olgraph:initial:set!
    olgraph:prepend-initial!
    make-olnode
    olnode?
    make-olnode/full
    olnode:id
    olnode:value
    olnode:children
    olnode:children:set!
    olnode:meta:set-value!
    olnode:meta:get-value
    olnode:copy
    olnode:prepend-child!)
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (scheme base)
          +
          _
          begin
          cons
          define
          define-syntax
          lambda
          let
          list
          procedure?
          quote
          set!
          syntax-rules
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/olgraph.scm")))
    (else (include "olgraph.scm"))))
