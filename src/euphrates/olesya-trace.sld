
(define-library
  (euphrates olesya-trace)
  (export
    olesya:trace
    olesya:trace:with-callback
    olesya:trace:begin
    olesya:trace:term
    olesya:trace:rule
    olesya:trace:map
    olesya:trace:eval
    olesya:trace:in-eval?
    olesya:trace:let
    olesya:trace:let-stack
    olesya:trace:=
    olesya:trace:define)
  (import
    (only (euphrates olesya-language)
          olesya:eval:name
          olesya:language:map
          olesya:language:rule
          olesya:language:term
          olesya:rule:make))
  (import
    (only (euphrates olesya-treeify)
          olesya:treeify:let
          olesya:treeify:map
          olesya:treeify:rule
          olesya:treeify:term))
  (import
    (only (scheme base)
          =
          _
          begin
          cons
          define
          define-syntax
          lambda
          let
          list
          make-parameter
          map
          parameterize
          quote
          syntax-rules
          values))
  (import (only (scheme eval) environment eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/olesya-trace.scm")))
    (else (include "olesya-trace.scm"))))
