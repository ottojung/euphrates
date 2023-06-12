
(define-library
  (euphrates
    time-get-monotonic-nanoseconds-timestamp)
  (export time-get-monotonic-nanoseconds-timestamp)
  (import
    (only (scheme base)
          *
          +
          _
          begin
          ceiling
          cond-expand
          define
          lambda
          let)
    (only (srfi srfi-19)
          current-time
          time-monotonic
          time-nanosecond
          time-second))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/time-get-monotonic-nanoseconds-timestamp.scm")))
    (else (include
            "time-get-monotonic-nanoseconds-timestamp.scm"))))
