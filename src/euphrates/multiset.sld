
(define-library
  (euphrates multiset)
  (export
    make-multiset
    multiset?
    list->multiset
    vector->multiset
    multiset->list
    multiset-equal?
    multiset-ref
    multiset-add!
    multiset-filter)
  (import
    (only (euphrates hashmap)
          hashmap->alist
          hashmap-count
          hashmap-foreach
          hashmap-ref
          hashmap-set!
          make-hashmap)
    (only (euphrates multiset-obj)
          multiset-constructor
          multiset-predicate
          multiset-value)
    (only (euphrates raisu) raisu)
    (only (scheme base)
          +
          -
          >=
          and
          begin
          car
          cond
          define
          else
          equal?
          eqv?
          for-each
          lambda
          let
          list?
          map
          quote
          set!
          unless
          vector-length
          vector-ref
          vector?
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/multiset.scm")))
    (else (include "multiset.scm"))))
