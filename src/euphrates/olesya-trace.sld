
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
    olesya:trace:define
    olesya:traced-object:trace
    olesya:traced-object:value
    olesya:traced-object?)
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates olesya-language)
          olesya:language:map
          olesya:language:rule
          olesya:language:term
          olesya:rule:name))
  (import
    (only (euphrates olesya-treeify)
          olesya:treeify:map
          olesya:treeify:rule
          olesya:treeify:term))
  (import
    (only (scheme base)
          =
          _
          begin
          define
          define-syntax
          if
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
