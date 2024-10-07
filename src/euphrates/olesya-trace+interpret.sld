
(define-library
  (euphrates olesya-trace+interpret)
  (export
    olesya:trace+interpret
    olesya:trace+interpret:run
    olesya:trace+interpret:begin
    olesya:trace+interpret:term
    olesya:trace+interpret:rule
    olesya:trace+interpret:map
    olesya:trace+interpret:eval
    olesya:trace+interpret:=
    olesya:trace+interpret:define
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
             (include-from-path
               "euphrates/olesya-trace+interpret.scm")))
    (else (include "olesya-trace+interpret.scm"))))
