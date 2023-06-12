
(define-library
  (euphrates sleep-until)
  (export sleep-until)
  (import
    (only (euphrates dynamic-thread-get-delay-procedure)
          dynamic-thread-get-delay-procedure)
    (only (euphrates dynamic-thread-yield)
          dynamic-thread-yield)
    (only (euphrates
            time-get-monotonic-nanoseconds-timestamp)
          time-get-monotonic-nanoseconds-timestamp)
    (only (euphrates unit-conversions)
          milli->nano/unit)
    (only (scheme base)
          +
          >
          _
          and
          begin
          define-syntax
          let
          or
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/sleep-until.scm")))
    (else (include "sleep-until.scm"))))
