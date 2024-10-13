
(define-library
  (euphrates olesya-language)
  (export
    olesya:term:name
    olesya:rule:name
    olesya:eval:name
    olesya:substitution:name
    olesya:language:run
    olesya:language:begin
    olesya:language:term
    olesya:language:rule
    olesya:language:let
    olesya:language:map
    olesya:language:=
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
          stack-make))
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
          quote
          syntax-rules
          values
          when))
  (import (only (scheme eval) eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olesya-language.scm")))
    (else (include "olesya-language.scm"))))
