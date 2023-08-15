
(define-library
  (euphrates hashmap)
  (export
    make-hashmap
    hashmap?
    hashmap->alist
    hashmap-copy
    hashmap-foreach
    hashmap-map
    alist->hashmap
    multi-alist->hashmap
    hashmap-has?
    hashmap-ref
    hashmap-set!
    hashmap-clear!
    hashmap-count
    hashmap-delete!
    hashmap-merge!
    hashmap-merge)
  (import
    (only (euphrates alist-to-hashmap-native)
          alist->hashmap/native))
  (import (only (euphrates fn) fn))
  (import
    (only (euphrates hashmap-obj)
          hashmap-constructor
          hashmap-predicate))
  (import
    (only (euphrates make-unique) make-unique))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          _
          begin
          car
          cdr
          cond-expand
          cons
          define
          define-syntax
          eq?
          for-each
          if
          lambda
          let
          not
          quote
          syntax-rules))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import
             (only (guile)
                   include-from-path
                   hash-ref
                   hash-set!
                   hash-clear!
                   hash-count
                   hash-for-each
                   hash-map->list
                   hash-remove!))
           (import
             (only (ice-9 hash-table) alist->hash-table))
           (begin
             (include-from-path "euphrates/hashmap.scm")))
    (else (include "hashmap.scm"))))
