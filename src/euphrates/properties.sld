
(define-library
  (euphrates properties)
  (export
    define-property
    with-properties
    make-property
    set-property!
    get-property
    unset-property!
    outdate-property!
    make-provider
    make-provider/general
    property-evaluatable?
    define-provider)
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates define-pair) define-pair))
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates hashmap)
          hashmap-delete!
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-delete!
          hashset-has?
          make-hashset))
  (import
    (only (euphrates immutable-hashmap)
          immutable-hashmap-ref
          immutable-hashmap-set
          make-immutable-hashmap))
  (import
    (only (euphrates list-maximal-element-or-proj)
          list-maximal-element-or/proj))
  (import
    (only (euphrates list-maximal-element-or)
          list-maximal-element-or))
  (import
    (only (euphrates make-unique) make-unique))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import
    (only (scheme base)
          +
          <
          >
          _
          and
          begin
          call-with-values
          car
          cond
          cons
          define
          define-syntax
          dynamic-wind
          else
          eq?
          equal?
          for-each
          if
          lambda
          length
          let
          let*
          list
          list-ref
          make-parameter
          map
          not
          null?
          number?
          or
          parameterize
          procedure?
          quote
          set!
          syntax-rules
          unless
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) list-index)))
    (else (import (only (srfi 1) list-index))))
  (cond-expand
    (guile (import (only (srfi srfi-18) current-time)))
    (else (import (only (srfi 18) current-time))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/properties.scm")))
    (else (include "properties.scm"))))
