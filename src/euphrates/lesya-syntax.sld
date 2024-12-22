
(define-library
  (euphrates lesya-syntax)
  (export
    lesya:syntax:let:make
    lesya:syntax:let?
    lesya:syntax:let:check
    lesya:syntax:let:destruct
    lesya:syntax:eval:make
    lesya:syntax:eval?
    lesya:syntax:eval:check
    lesya:syntax:eval:destruct
    lesya:syntax:rule:make
    lesya:syntax:rule?
    lesya:syntax:rule:check
    lesya:syntax:rule:destruct
    lesya:syntax:substitution:make
    lesya:syntax:substitution?
    lesya:syntax:substitution:check
    lesya:syntax:substitution:destruct
    lesya:syntax:implication:make
    lesya:syntax:implication?
    lesya:syntax:implication:check
    lesya:syntax:implication:destruct
    lesya:syntax:specify:make
    lesya:syntax:specify?
    lesya:syntax:specify:check
    lesya:syntax:specify:destruct
    lesya:syntax:axiom:make
    lesya:syntax:axiom?
    lesya:syntax:axiom:check
    lesya:syntax:axiom:destruct
    lesya:syntax:begin:make)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import
    (only (scheme base)
          and
          apply
          begin
          cadr
          car
          cdr
          cons
          define
          equal?
          error
          if
          let
          list
          list?
          map
          not
          or
          pair?
          quote
          symbol?
          values
          when))
  (import (only (scheme eval) eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/lesya-syntax.scm")))
    (else (include "lesya-syntax.scm"))))
