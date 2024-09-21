
(define-library
  (euphrates lesya-language)
  (export
    lesya:language
    lesya:language:run
    lesya:language:begin
    lesya:language:axiom
    lesya:language:map
    lesya:language:eval
    lesya:language:list
    lesya:language:when
    lesya:language:apply
    lesya:language:alpha
    lesya:language:beta
    lesya:language:let
    lesya:language:define)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates hashmap)
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates list-fold-semigroup)
          list-fold/semigroup))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates stack)
          stack->list
          stack-empty?
          stack-make
          stack-pop!
          stack-push!))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          _
          and
          begin
          car
          cdr
          cond
          cons
          define
          define-syntax
          define-values
          else
          equal?
          if
          let
          list
          list?
          make-parameter
          map
          not
          null?
          pair?
          parameterize
          quasiquote
          quote
          symbol?
          syntax-rules
          unless
          unquote
          values
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lesya-language.scm")))
    (else (include "lesya-language.scm"))))
