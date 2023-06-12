
(define-library
  (test-time-get-current-unixtime)
  (import
    (only (euphrates assert) assert)
    (only (euphrates time-get-current-unixtime)
          time-get-current-unixtime)
    (only (scheme base) begin let number?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-time-get-current-unixtime.scm")))
    (else (include "test-time-get-current-unixtime.scm"))))
