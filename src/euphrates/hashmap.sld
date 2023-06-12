
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
    (only (euphrates fn) fn)
    (only (euphrates hashmap-obj)
          hashmap-constructor
          hashmap-predicate)
    (only (euphrates make-unique) make-unique)
    (only (euphrates raisu) raisu)
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
          syntax-rules)
    (only (scheme case-lambda) case-lambda))
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
