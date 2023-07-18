
(define-library
  (test-assert-called-once)
  (import
    (only (euphrates assert-called-once)
          assert-called-once
          with-called-once-extent))
  (import (only (euphrates catch-any) catch-any))
  (import
    (only (scheme base)
          +
          _
          and
          begin
          cond-expand
          define
          define-values
          equal?
          lambda
          let
          newline
          set!
          unless
          values))
  (import (only (scheme process-context) exit))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-assert-called-once.scm")))
    (else (include "test-assert-called-once.scm"))))
