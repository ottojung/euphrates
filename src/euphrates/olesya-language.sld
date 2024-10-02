
(define-library
  (euphrates olesya-language)
  (export
    olesya:language:run
    olesya:language:begin
    olesya:language:axiom
    olesya:language:map
    olesya:language:eval
    olesya:language:specify
    olesya:language:=
    olesya:language:let
    olesya:language:define)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates list-length-eq) list-length=))
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
          apply
          begin
          call-with-current-continuation
          car
          cdr
          cond
          cons
          define
          define-syntax
          define-values
          else
          equal?
          error
          if
          lambda
          let
          list
          list?
          make-parameter
          map
          not
          null?
          or
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
               "euphrates/olesya-language.scm")))
    (else (include "olesya-language.scm"))))
