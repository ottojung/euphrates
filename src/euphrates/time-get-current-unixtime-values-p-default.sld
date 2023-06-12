
(define-library
  (euphrates
    time-get-current-unixtime-values-p-default)
  (export
    #{time-get-current-unixtime/values#p-default}#)
  (import
    (only (scheme base)
          begin
          cond-expand
          define
          let
          values)
    (only (srfi srfi-19)
          current-time
          time-nanosecond
          time-second
          time-utc))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/time-get-current-unixtime-values-p-default.scm")))
    (else (include
            "time-get-current-unixtime-values-p-default.scm"))))
