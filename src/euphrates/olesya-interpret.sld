
(define-library
  (euphrates olesya-interpret)
  (export olesya:interpret olesya:language:eval)
  (import
    (only (euphrates olesya-language)
          olesya:language:=
          olesya:language:begin
          olesya:language:define
          olesya:language:let
          olesya:language:map
          olesya:language:rule
          olesya:language:run
          olesya:language:term))
  (import
    (only (scheme base)
          =
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
