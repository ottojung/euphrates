
(define-library
  (euphrates lesya-axiom-to-olesya-object)
  (export lesya-axiom->olesya-object)
  (import
    (only (euphrates list-length-eq) list-length=))
  (import
    (only (euphrates olesya-syntax)
          olesya:syntax:term:make))
  (import
    (only (scheme base)
          and
          begin
          car
          cdr
          cond
          cons
          define
          else
          equal?
          let
          list?
          map
          pair?
          quote
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lesya-axiom-to-olesya-object.scm")))
    (else (include "lesya-axiom-to-olesya-object.scm"))))
