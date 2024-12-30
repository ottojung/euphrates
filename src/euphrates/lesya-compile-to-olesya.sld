
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
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates lesya-axiom-to-olesya-object)
          lesya-axiom->olesya-object))
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
    (only (euphrates list-fold-semigroup)
          list-fold/semigroup))
  (import (only (euphrates list-last) list-last))
  (import
    (only (euphrates make-unique) make-unique))
  (import
    (only (euphrates olesya-interpret)
          olesya:interpret:eval
          olesya:interpret:map
          olesya:interpret:with-error-possibility))
  (import
    (only (euphrates olesya-interpretation-return)
          olesya:return:fail?))
  (import
    (only (euphrates olesya-syntax)
          olesya:syntax:begin:make
          olesya:syntax:define:make
          olesya:syntax:eval:make
          olesya:syntax:let:make
          olesya:syntax:rule:make
          olesya:syntax:substitution:make))
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          =
          _
          append
          apply
          begin
          cadr
          car
          cdr
          cons
          define
          define-syntax
          define-values
          eq?
          equal?
          if
          lambda
          let
          list
          make-parameter
          map
          null?
          parameterize
          quote
          reverse
          symbol?
          syntax-rules
          values
          when))
  (import (only (scheme eval) environment eval))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lesya-compile-to-olesya.scm")))
    (else (include "lesya-compile-to-olesya.scm"))))
