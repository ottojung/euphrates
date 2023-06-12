
(define-library
  (euphrates properties)
  (export define-property)
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap)
    (only (euphrates make-unique) make-unique)
    (only (euphrates memconst) memconst)
    (only (euphrates raisu) raisu)
    (only (scheme base)
          _
          begin
          define
          define-syntax
          eq?
          if
          let
          quote
          syntax-rules)
    (only (scheme case-lambda) case-lambda)
    (only (srfi srfi-17) setter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/properties.scm")))
    (else (include "properties.scm"))))
