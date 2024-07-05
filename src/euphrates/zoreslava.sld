
(define-library
  (euphrates zoreslava)
  (export
    zoreslava/p
    with-zoreslava
    zoreslava:began?
    zoreslava:equal?
    zoreslava:set!
    zoreslava:ref
    zoreslava:has?
    zoreslava:serialize
    zoreslava:deserialize
    zoreslava:write
    zoreslava:read)
  (import
    (only (euphrates define-pair) define-pair))
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates hashmap)
          hashmap-has?
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates hashset)
          hashset-equal?
          list->hashset))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates read-list) read-list))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          _
          begin
          car
          cons
          current-input-port
          current-output-port
          define
          define-syntax
          for-each
          if
          lambda
          length
          let
          list
          list?
          make-parameter
          map
          newline
          not
          or
          parameterize
          quote
          string->symbol
          string?
          symbol?
          syntax-rules
          unless
          values
          when))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme write) write))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/zoreslava.scm")))
    (else (include "zoreslava.scm"))))
