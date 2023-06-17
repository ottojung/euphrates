
(define-library
  (euphrates sleep-until)
  (export sleep-until)
  (import
    (only (euphrates dynamic-thread-get-delay-procedure)
          dynamic-thread-get-delay-procedure))
  (import
    (only (euphrates dynamic-thread-yield)
          dynamic-thread-yield))
  (import
    (only (euphrates
            time-get-monotonic-nanoseconds-timestamp)
          time-get-monotonic-nanoseconds-timestamp))
  (import
    (only (euphrates unit-conversions)
          milli->nano/unit))
  (import
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
