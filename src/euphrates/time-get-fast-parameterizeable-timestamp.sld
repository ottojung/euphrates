
(define-library
  (euphrates
    time-get-fast-parameterizeable-timestamp)
  (export time-get-fast-parameterizeable-timestamp)
  (import
    (only (euphrates fast-parameterizeable-timestamp-p)
          fast-parameterizeable-timestamp/p))
  (import (only (scheme base) begin define or))
  (import (only (scheme time) current-jiffy))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/time-get-fast-parameterizeable-timestamp.scm")))
    (else (include
            "time-get-fast-parameterizeable-timestamp.scm"))))
