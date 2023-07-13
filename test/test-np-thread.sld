
(define-library
  (test-np-thread)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates dynamic-thread-cancel)
          dynamic-thread-cancel)
    (only (euphrates dynamic-thread-spawn)
          dynamic-thread-spawn)
    (only (euphrates dynamic-thread-yield)
          dynamic-thread-yield)
    (only (euphrates lines-to-string) lines->string)
    (only (euphrates np-thread-parameterize)
          with-np-thread-env/non-interruptible)
    (only (euphrates with-output-stringified)
          with-output-stringified)
    (only (scheme base)
          +
          =
          >
          begin
          define
          if
          lambda
          let
          list
          number->string
          set!
          string-append
          when)
    (only (scheme case-lambda) case-lambda)
    (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-np-thread.scm")))
    (else (include "test-np-thread.scm"))))
