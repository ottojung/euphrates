
(define-library
  (euphrates lesya-object-to-olesya-object)
  (export lesya-object->olesya-object)
  (import
    (only (euphrates lesya-axiom-to-olesya-object)
          lesya-axiom->olesya-object))
  (import
    (only (euphrates lesya-syntax)
          lesya:syntax:axiom:destruct
          lesya:syntax:axiom?
          lesya:syntax:rule:destruct
          lesya:syntax:rule?
          lesya:syntax:specify:destruct
          lesya:syntax:specify?
          lesya:syntax:substitution:destruct
          lesya:syntax:substitution?))
  (import
    (only (euphrates olesya-interpretation-return)
          olesya:return:map
          olesya:return:ok?))
  (import
    (only (euphrates olesya-syntax)
          olesya:syntax:rule:make
          olesya:syntax:substitution:make))
  (import
    (only (scheme base)
          begin
          cond
          define
          define-values
          else
          let
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lesya-object-to-olesya-object.scm")))
    (else (include "lesya-object-to-olesya-object.scm"))))
