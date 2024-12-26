
(define-library
  (euphrates olesya-interpret)
  (export
    olesya:interpret
    olesya:interpret:with-error-possibility
    olesya:interpret:eval
    olesya:interpret:term
    olesya:interpret:rule
    olesya:interpret:map
    olesya:interpret:let
    olesya:interpret:define
    olesya:interpret:begin
    olesya:interpret:=)
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates olesya-interpretation-return)
          olesya:return:fail
          olesya:return:ok))
  (import
    (only (euphrates olesya-syntax)
          olesya:syntax:rule:destruct
          olesya:syntax:rule:make
          olesya:syntax:term:make))
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import
    (only (scheme base)
          =
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
          syntax-rules
          unless))
  (import (only (scheme eval) environment eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olesya-interpret.scm")))
    (else (include "olesya-interpret.scm"))))
