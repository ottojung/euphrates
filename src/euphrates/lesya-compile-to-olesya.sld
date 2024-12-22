
(define-library
  (euphrates lesya-compile-to-olesya)
  (export
    lesya:compile/->olesya
    lesya:compile/->olesya:axiom
    lesya:compile/->olesya:define
    lesya:compile/->olesya:apply
    lesya:compile/->olesya:begin
    lesya:compile/->olesya:specify
    lesya:compile/->olesya:let
    lesya:compile/->olesya:=
    lesya:compile/->olesya:map
    lesya:compile/->olesya:eval)
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates lesya-syntax)
          lesya:syntax:axiom:make))
  (import
    (only (euphrates lexical-scope)
          lexical-scope-make
          lexical-scope-ref
          lexical-scope-set!
          lexical-scope-stage!
          lexical-scope-unstage!))
  (import
    (only (euphrates make-unique) make-unique))
  (import
    (only (euphrates olesya-interpret)
          olesya:interpret:map))
  (import
    (only (euphrates olesya-syntax)
          olesya:syntax:begin:make
          olesya:syntax:define:make
          olesya:syntax:let:make
          olesya:syntax:rule:make
          olesya:syntax:substitution:make
          olesya:syntax:term:make))
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          =
          _
          and
          apply
          begin
          cadr
          car
          define
          define-syntax
          define-values
          eq?
          equal?
          if
          length
          let
          list
          list?
          make-parameter
          map
          parameterize
          quasiquote
          quote
          symbol?
          syntax-error
          syntax-rules
          unquote
          values))
  (import (only (scheme cxr) caddr))
  (import (only (scheme eval) environment eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lesya-compile-to-olesya.scm")))
    (else (include "lesya-compile-to-olesya.scm"))))
