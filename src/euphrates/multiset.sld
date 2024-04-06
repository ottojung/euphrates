
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
    multiset-has?
    multiset-add!
    multiset-filter)
  (import
    (only (euphrates hashmap)
          hashmap->alist
          hashmap-count
          hashmap-foreach
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates hashset-obj) hashset-value))
  (import
    (only (euphrates multiset-obj)
          multiset-constructor
          multiset-predicate
          multiset-value))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          +
          -
          >=
          _
          and
          begin
          car
          cons
          define
          define-syntax
          equal?
          eqv?
          for-each
          lambda
          let
          map
          or
          quote
          set!
          syntax-rules
          unless
          vector-length
          vector-ref
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) iota)))
    (else (import (only (srfi 1) iota))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/multiset.scm")))
    (else (include "multiset.scm"))))
