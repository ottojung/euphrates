
(define-library
  (euphrates immutable-hashmap)
  (export
    make-immutable-hashmap
    immutable-hashmap?
    immutable-hashmap-fromlist
    immutable-hashmap->alist
    immutable-hashmap-copy
    immutable-hashmap-foreach
    immutable-hashmap-map
    alist->immutable-hashmap
    immutable-hashmap-ref
    immutable-hashmap-ref/first
    immutable-hashmap-set
    immutable-hashmap-clear
    immutable-hashmap-count)
  (import (only (euphrates assoc-any) assoc/any))
  (import (only (euphrates fn) fn))
  (import
    (only (euphrates immutable-hashmap-obj)
          immutable-hashmap-constructor
          immutable-hashmap-predicate
          immutable-hashmap-value))
  (import
    (only (scheme base)
          append
          assoc
          begin
          car
          cdr
          cons
          define
          equal?
          for-each
          if
          lambda
          length
          let
          map
          null?
          or
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/immutable-hashmap.scm")))
    (else (include "immutable-hashmap.scm"))))
