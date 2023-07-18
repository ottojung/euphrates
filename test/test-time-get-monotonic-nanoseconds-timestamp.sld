
(define-library
  (test-time-get-monotonic-nanoseconds-timestamp)
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates
            time-get-monotonic-nanoseconds-timestamp)
          time-get-monotonic-nanoseconds-timestamp))
  (import
    (only (scheme base)
          >
          begin
          cond-expand
          integer?
          let
          number?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-time-get-monotonic-nanoseconds-timestamp.scm")))
    (else (include
            "test-time-get-monotonic-nanoseconds-timestamp.scm"))))
