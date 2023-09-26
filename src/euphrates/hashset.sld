
(define-library
  (euphrates hashset)
  (export
    make-hashset
    list->hashset
    vector->hashset
    hashset-null?
    hashset-length
    hashset->list
    hashset-equal?
    hashset-has?
    hashset-ref
    hashset-add!
    hashset-contains?
    hashset-difference
    hashset-intersection
    hashset-union
    hashset-foreach
    hashset-map
    hashset-clear!
    hashset-delete!)
  (import (only (euphrates fn) fn))
  (import
    (only (euphrates hashmap)
          hashmap->alist
          hashmap-clear!
          hashmap-count
          hashmap-delete!
          hashmap-foreach
          hashmap-map
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates hashset-obj)
          hashset-constructor
          hashset-predicate
          hashset-value))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          -
          =
          >=
          _
          and
          begin
          car
          cond
          define
          define-syntax
          else
          equal?
          for-each
          lambda
          let
          list?
          map
          or
          quote
          set!
          syntax-rules
          unless
          vector-length
          vector-ref
          vector?
          when))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/hashset.scm")))
    (else (include "hashset.scm"))))
