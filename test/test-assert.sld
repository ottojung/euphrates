
(define-library
  (test-assert)
  (import
    (only (euphrates assert) assert)
    (only (euphrates catch-any) catch-any)
    (only (scheme base)
          +
          -
          =
          _
          begin
          equal?
          lambda
          let
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-assert.scm")))
    (else (include "test-assert.scm"))))
