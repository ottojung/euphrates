
(define-library
  (test-np-thread)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates dynamic-thread-cancel)
          dynamic-thread-cancel))
  (import
    (only (euphrates dynamic-thread-spawn)
          dynamic-thread-spawn))
  (import
    (only (euphrates dynamic-thread-yield)
          dynamic-thread-yield))
  (import
    (only (euphrates lines-to-string) lines->string))
  (import
    (only (euphrates np-thread-parameterize)
          with-np-thread-env/non-interruptible))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (scheme base)
          +
          =
          >
          begin
          cond-expand
          define
          if
          let
          list
          number->string
          set!
          string-append
          when))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-np-thread.scm")))
    (else (include "test-np-thread.scm"))))
