
(define-library
  (euphrates olesya-trace)
  (export
    olesya:trace
    olesya:trace:run
    olesya:trace:begin
    olesya:trace:term
    olesya:trace:rule
    olesya:trace:map
    olesya:trace:eval
    olesya:trace:=
    olesya:trace:define)
  (import
    (only (euphrates olesya-language)
          olesya:rule:name
          olesya:term:name))
  (import
    (only (scheme base)
          =
          _
          begin
          cons
          define
          define-syntax
          let
          list
          map
          quote
          syntax-rules))
  (import (only (scheme eval) environment eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/olesya-trace.scm")))
    (else (include "olesya-trace.scm"))))
