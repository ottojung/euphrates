
(define-library
  (test-olesya-interpret)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates olesya-interpret)
          olesya:interpret))
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import
    (only (scheme base)
          =
          begin
          car
          cdr
          cond
          define
          define-values
          else
          equal?
          error
          if
          map
          quasiquote
          quote
          unless
          values
          when))
  (import (only (scheme eval) eval))
  (import (only (scheme process-context) exit))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-olesya-interpret.scm")))
    (else (include "test-olesya-interpret.scm"))))
