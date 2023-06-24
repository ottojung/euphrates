
(define-library
  (euphrates properties)
  (export define-property with-properties)
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
    (only (scheme base)
          _
          and
          begin
          define
          define-syntax
          eq?
          if
          lambda
          let
          make-parameter
          parameterize
          quote
          syntax-rules
          unless))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (srfi srfi-17) setter)))
    (else (import (only (srfi 17) setter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/properties.scm")))
    (else (include "properties.scm"))))
