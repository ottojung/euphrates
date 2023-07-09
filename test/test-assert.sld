
(define-library
  (test-assert)
  (import (only (euphrates assert) assert))
  (import (only (euphrates catch-any) catch-any))
  (import
    (only (scheme base)
          *
          +
          =
          _
          begin
          define
          equal?
          lambda
          let
          newline
          not
          quote
          set!
          unless))
  (import (only (scheme process-context) exit))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-assert.scm")))
    (else (include "test-assert.scm"))))
