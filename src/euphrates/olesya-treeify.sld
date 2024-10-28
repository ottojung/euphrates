
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
    olesya:treeify:let
    olesya:treeify:=
    olesya:treeify:define)
  (import
    (only (euphrates olesya-syntax)
          olesya:syntax:begin:make
          olesya:syntax:eval:make
          olesya:syntax:let:make
          olesya:syntax:rule:make
          olesya:syntax:substitution:make
          olesya:syntax:term:make))
  (import
    (only (scheme base)
          =
          _
          begin
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
