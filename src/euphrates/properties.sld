
(define-library
  (euphrates properties)
  (export
    define-property
    with-properties
    make-property
    set-property!
    make-provider
    make-provider/general
    define-provider)
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates hashmap)
          hashmap-delete!
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates immutable-hashmap)
          immutable-hashmap-ref
          immutable-hashmap-set
          make-immutable-hashmap))
  (import
    (only (euphrates make-unique) make-unique))
  (import (only (euphrates memconst) memconst))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import
    (only (scheme base)
          +
          _
          and
          apply
          begin
          car
          cdr
          define
          define-syntax
          define-values
          eq?
          for-each
          if
          lambda
          let
          make-parameter
          map
          null?
          parameterize
          quote
          set!
          syntax-rules
          unless
          values))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (srfi srfi-17) setter)))
    (else (import (only (srfi 17) setter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/properties.scm")))
    (else (include "properties.scm"))))
