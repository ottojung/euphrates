
(define-library
  (euphrates lesya-interpret)
  (export
    lesya:interpret
    lesya:interpret:axiom
    lesya:interpret:define
    lesya:interpret:apply
    lesya:interpret:begin
    lesya:interpret:specify
    lesya:interpret:let
    lesya:interpret:=
    lesya:interpret:map
    lesya:interpret:eval)
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates lesya-syntax)
          lesya:syntax:implication:destruct
          lesya:syntax:implication:make
          lesya:syntax:implication?
          lesya:syntax:rule:destruct
          lesya:syntax:rule?
          lesya:syntax:specify:destruct
          lesya:syntax:specify:make
          lesya:syntax:specify?
          lesya:syntax:substitution:destruct
          lesya:syntax:substitution?))
  (import
    (only (euphrates list-fold-semigroup)
          list-fold/semigroup))
  (import
    (only (euphrates stack)
          stack->list
          stack-empty?
          stack-make
          stack-pop!
          stack-push!))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          =
          _
          and
          apply
          begin
          call-with-current-continuation
          car
          cdr
          cond
          cons
          define
          define-syntax
          define-values
          else
          equal?
          error
          if
          lambda
          let
          list
          list?
          make-parameter
          map
          not
          null?
          pair?
          parameterize
          quasiquote
          quote
          symbol?
          syntax-rules
          unless
          unquote))
  (import (only (scheme eval) environment eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lesya-interpret.scm")))
    (else (include "lesya-interpret.scm"))))
