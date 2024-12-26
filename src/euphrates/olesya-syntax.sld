
(define-library
  (euphrates olesya-syntax)
  (export
    olesya:syntax:let:make
    olesya:syntax:let?
    olesya:syntax:let:check
    olesya:syntax:let:destruct
    olesya:syntax:eval:make
    olesya:syntax:eval?
    olesya:syntax:eval:check
    olesya:syntax:eval:destruct
    olesya:syntax:rule:make
    olesya:syntax:rule?
    olesya:syntax:rule:check
    olesya:syntax:rule:destruct
    olesya:syntax:define:make
    olesya:syntax:define?
    olesya:syntax:define:check
    olesya:syntax:define:destruct
    olesya:syntax:substitution:make
    olesya:syntax:substitution?
    olesya:syntax:substitution:check
    olesya:syntax:substitution:destruct
    olesya:syntax:term:make
    olesya:syntax:term?
    olesya:syntax:term:check
    olesya:syntax:term:destruct
    olesya:syntax:begin:make
    olesya:syntax:begin?
    olesya:syntax:begin:check
    olesya:syntax:begin:destruct)
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import
    (only (scheme base)
          and
          apply
          begin
          car
          cdr
          cons
          define
          equal?
          error
          let
          list
          list?
          map
          not
          or
          pair?
          quote
          values
          when))
  (import (only (scheme eval) eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/olesya-syntax.scm")))
    (else (include "olesya-syntax.scm"))))
