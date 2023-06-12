
(define-library
  (euphrates universal-usleep)
  (export universal-usleep)
  (import
    (only (euphrates dynamic-thread-get-wait-delay)
          dynamic-thread-get-wait-delay)
    (only (euphrates dynamic-thread-get-yield-procedure)
          dynamic-thread-get-yield-procedure)
    (only (euphrates sys-usleep) sys-usleep)
    (only (euphrates
            time-get-monotonic-nanoseconds-timestamp)
          time-get-monotonic-nanoseconds-timestamp)
    (only (euphrates unit-conversions)
          micro->nano/unit
          nano->micro/unit)
    (only (scheme base)
          +
          -
          >
          begin
          define
          let
          let*
          min
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/universal-usleep.scm")))
    (else (include "universal-usleep.scm"))))
