
(define-library
  (test-time-get-current-unixtime)
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates time-get-current-unixtime)
          time-get-current-unixtime))
  (import
    (only (scheme base)
          begin
          cond-expand
          let
          number?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-time-get-current-unixtime.scm")))
    (else (include "test-time-get-current-unixtime.scm"))))
