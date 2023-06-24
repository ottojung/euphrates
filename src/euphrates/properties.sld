
(define-library
  (euphrates properties)
  (export
    define-property
    with-properties
    make-property
    make-provider
    define-provider)
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates hashmap)
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
          begin
          car
          cdr
          define
          define-syntax
          define-values
          eq?
          if
          lambda
          let
          list
          make-parameter
          null?
          parameterize
          quote
          set!
          syntax-rules
          unless))
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
