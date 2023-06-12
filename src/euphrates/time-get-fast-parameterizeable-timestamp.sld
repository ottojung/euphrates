
(define-library
  (euphrates
    time-get-fast-parameterizeable-timestamp)
  (export time-get-fast-parameterizeable-timestamp)
  (import
    (only (euphrates fast-parameterizeable-timestamp-p)
          fast-parameterizeable-timestamp/p)
    (only (euphrates
            time-get-monotonic-nanoseconds-timestamp)
          time-get-monotonic-nanoseconds-timestamp)
    (only (scheme base) begin define or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/time-get-fast-parameterizeable-timestamp.scm")))
    (else (include
            "time-get-fast-parameterizeable-timestamp.scm"))))
