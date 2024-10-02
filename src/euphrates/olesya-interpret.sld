
(define-library
  (euphrates olesya-interpret)
  (export olesya:interpret)
  (import
    (only (euphrates olesya-language)
          olesya:language:=
          olesya:language:apply
          olesya:language:axiom
          olesya:language:begin
          olesya:language:define
          olesya:language:eval
          olesya:language:let
          olesya:language:map
          olesya:language:run
          olesya:language:specify))
  (import
    (only (scheme base)
          =
          apply
          begin
          define
          let
          map
          quasiquote
          quote
          unquote))
  (import (only (scheme eval) environment eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/olesya-interpret.scm")))
    (else (include "olesya-interpret.scm"))))
