
(define-library
  (euphrates lesya-axiom-to-olesya-object)
  (export lesya-axiom->olesya-object)
  (import
    (only (euphrates lesya-syntax)
          lesya:syntax:axiom:destruct
          lesya:syntax:axiom?
          lesya:syntax:implication:destruct
          lesya:syntax:implication?
          lesya:syntax:rule:destruct
          lesya:syntax:rule?
          lesya:syntax:specify:destruct
          lesya:syntax:specify?
          lesya:syntax:substitution:destruct
          lesya:syntax:substitution?))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import
    (only (euphrates olesya-syntax)
          olesya:syntax:rule:make
          olesya:syntax:substitution:make
          olesya:syntax:term:make))
  (import
    (only (scheme base)
          and
          begin
          car
          cond
          define
          define-values
          else
          equal?
          let
          list?
          make-parameter
          map
          not
          parameterize
          quote
          unquote
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lesya-axiom-to-olesya-object.scm")))
    (else (include "lesya-axiom-to-olesya-object.scm"))))
