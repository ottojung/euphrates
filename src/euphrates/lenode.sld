
(define-library
  (euphrates lenode)
  (export
    lenode:make
    lenode?
    lenode:add-child!
    lenode:get-child
    lenode:labels)
  (import
    (only (euphrates euphrates-list-sort)
          euphrates:list-sort))
  (import
    (only (euphrates hashmap)
          hashmap->alist
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates make-unique) make-unique))
  (import
    (only (euphrates olgraph)
          make-olnode
          olnode:meta:get-value
          olnode:meta:set-value!
          olnode?))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (scheme base)
          _
          and
          begin
          car
          define
          define-syntax
          lambda
          let
          map
          string<?
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/lenode.scm")))
    (else (include "lenode.scm"))))
