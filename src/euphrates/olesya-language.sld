
(define-library
  (euphrates olesya-language)
  (export
    olesya:substitution?
    olesya:substitution:destruct
    olesya:language:run
    olesya:language:begin
    olesya:language:term
    olesya:language:rule
    olesya:language:let
    olesya:language:map
    olesya:language:=
    olesya:language:define)
  (import
    (only (euphrates olesya-syntax)
          olesya:syntax:rule:destruct
          olesya:syntax:rule:make
          olesya:syntax:term:make))
  (import
    (only (scheme base)
          _
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
          null?
          parameterize
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olesya-language.scm")))
    (else (include "olesya-language.scm"))))
