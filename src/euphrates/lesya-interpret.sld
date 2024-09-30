
(define-library
  (euphrates lesya-interpret)
  (export lesya:interpret)
  (import
    (only (euphrates lesya-language)
          lesya:language:=
          lesya:language:apply
          lesya:language:axiom
          lesya:language:begin
          lesya:language:define
          lesya:language:eval
          lesya:language:let
          lesya:language:list
          lesya:language:map
          lesya:language:run
          lesya:language:specify))
  (import
    (only (scheme base)
          =
          apply
          begin
          define
          let
          list
          map
          quasiquote
          quote
          unquote))
  (import (only (scheme eval) environment eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lesya-interpret.scm")))
    (else (include "lesya-interpret.scm"))))
