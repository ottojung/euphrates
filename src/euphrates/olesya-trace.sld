
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
    olesya:traced-object:operation
    olesya:traced-object:output
    olesya:traced-object?)
  (import
    (only (euphrates olesya-language)
          olesya:language:map
          olesya:language:rule
          olesya:language:term))
  (import
    (only (euphrates olesya-treeify)
          olesya:treeify:map))
  (import
    (only (scheme base)
          =
          _
          and
          begin
          define
          define-syntax
          equal?
          if
          let
          list
          map
          or
          quote
          syntax-rules
          vector
          vector-length
          vector-ref
          vector?))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme eval) environment eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/olesya-trace.scm")))
    (else (include "olesya-trace.scm"))))
