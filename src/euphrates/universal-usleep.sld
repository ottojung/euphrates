
(define-library
  (euphrates universal-usleep)
  (export universal-usleep)
  (import
    (only (euphrates dynamic-thread-get-wait-delay)
          dynamic-thread-get-wait-delay))
  (import
    (only (euphrates dynamic-thread-get-yield-procedure)
          dynamic-thread-get-yield-procedure))
  (import (only (euphrates sys-usleep) sys-usleep))
  (import
    (only (euphrates
            time-get-monotonic-nanoseconds-timestamp)
          time-get-monotonic-nanoseconds-timestamp))
  (import
    (only (euphrates unit-conversions)
          micro->nano/unit
          nano->micro/unit))
  (import
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
