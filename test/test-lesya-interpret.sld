
(define-library
  (test-lesya-interpret)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates lesya-interpret)
          lesya:interpret))
  (import
    (only (euphrates olesya-interpretation-return)
          olesya:return:fail
          olesya:return:ok
          olesya:return:type
          olesya:return:value))
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import
    (only (scheme base)
          =
          and
          apply
          begin
          cond
          define
          define-values
          else
          equal?
          if
          let
          map
          not
          or
          quasiquote
          quote
          unless
          unquote
          values
          when))
  (import (only (scheme eval) eval))
  (import (only (scheme process-context) exit))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-lesya-interpret.scm")))
    (else (include "test-lesya-interpret.scm"))))
