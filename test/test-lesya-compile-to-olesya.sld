
(define-library
  (test-lesya-compile-to-olesya)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debug) debug))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates lesya-compile-to-olesya)
          lesya:compile/->olesya))
  (import
    (only (euphrates lesya-interpret)
          lesya:interpret))
  (import
    (only (euphrates lesya-object-to-olesya-object)
          lesya-object->olesya-object))
  (import
    (only (euphrates olesya-interpret)
          olesya:interpret))
  (import
    (only (euphrates olesya-interpretation-return)
          olesya:return:fail?
          olesya:return:map
          olesya:return:ok))
  (import
    (only (euphrates olesya-syntax)
          olesya:syntax:term:make))
  (import
    (only (scheme base)
          =
          and
          apply
          begin
          define
          equal?
          if
          let
          map
          not
          or
          quasiquote
          quote
          unless
          when))
  (import (only (scheme eval) eval))
  (import (only (scheme process-context) exit))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-lesya-compile-to-olesya.scm")))
    (else (include "test-lesya-compile-to-olesya.scm"))))
