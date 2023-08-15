
(define-library
  (test-assert)
  (import (only (euphrates assert) assert))
  (import (only (euphrates catch-any) catch-any))
  (import
    (only (euphrates generic-error-irritants-key)
          generic-error:irritants-key))
  (import
    (only (euphrates generic-error-type-key)
          generic-error:type-key))
  (import
    (only (euphrates generic-error-value)
          generic-error:value))
  (import
    (only (scheme base)
          *
          +
          =
          _
          begin
          cond-expand
          cons
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
  (import (only (scheme write) display write))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-assert.scm")))
    (else (include "test-assert.scm"))))
