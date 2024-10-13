
(define-library
  (euphrates olesya-treeify)
  (export
    olesya:treeify
    olesya:treeify:run
    olesya:treeify:begin
    olesya:treeify:term
    olesya:treeify:rule
    olesya:treeify:map
    olesya:treeify:eval
    olesya:treeify:=
    olesya:treeify:define)
  (import
    (only (euphrates olesya-language)
          olesya:begin:name
          olesya:eval:name
          olesya:rule:name
          olesya:substitution:name
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
             (include-from-path
               "euphrates/olesya-treeify.scm")))
    (else (include "olesya-treeify.scm"))))
