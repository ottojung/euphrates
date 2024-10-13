
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
    olesya:syntax:term:make
    olesya:syntax:term?
    olesya:syntax:term:check
    olesya:syntax:term:destruct)
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
          define
          equal?
          error
          let
          list
          list?
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
