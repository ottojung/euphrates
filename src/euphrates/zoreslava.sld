
(define-library
  (euphrates zoreslava)
  (export
    zoreslava/p
    with-zoreslava
    zoreslava:equal?
    zoreslava:set!
    zoreslava:ref
    zoreslava:has?
    zoreslava:serialize
    zoreslava:deserialize
    zoreslava:write
    zoreslava:read
    zoreslava:eval)
  (import
    (only (euphrates define-pair) define-pair))
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (euphrates fn-cons) fn-cons))
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
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          _
          and
          begin
          cadr
          car
          cond
          cons
          current-input-port
          current-output-port
          define
          define-syntax
          else
          eq?
          equal?
          for-each
          if
          lambda
          length
          let
          list
          list?
          make-parameter
          map
          number?
          or
          pair?
          parameterize
          quasiquote
          quote
          reverse
          string->symbol
          string?
          symbol?
          syntax-rules
          unless
          unquote
          values
          when))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme eval) environment eval))
  (import (only (scheme read) read))
  (import (only (scheme write) write))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/zoreslava.scm")))
    (else (include "zoreslava.scm"))))
