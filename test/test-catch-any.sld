
(define-library
  (test-catch-any)
  (import (only (euphrates catch-any) catch-any))
  (import
    (only (euphrates generic-error-huh)
          generic-error?))
  (import
    (only (euphrates generic-error) generic-error))
  (import
    (only (scheme base)
          +
          =
          _
          begin
          car
          current-error-port
          define
          lambda
          length
          let
          newline
          quasiquote
          quote
          set!
          unless))
  (import (only (scheme process-context) exit))
  (import (only (scheme write) display write))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-catch-any.scm")))
    (else (include "test-catch-any.scm"))))
