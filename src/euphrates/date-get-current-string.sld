
(define-library
  (euphrates date-get-current-string)
  (export date-get-current-string)
  (import
    (only (euphrates time-get-current-unixtime)
          time-get-current-unixtime/values))
  (import
    (only (scheme base)
          begin
          cond-expand
          define
          define-values
          quote))
  (cond-expand
    (guile (import
             (only (srfi srfi-19)
                   date->string
                   make-time
                   time-utc
                   time-utc->date)))
    (else (import
            (only (srfi 19)
                  date->string
                  make-time
                  time-utc
                  time-utc->date))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/date-get-current-string.scm")))
    (else (include "date-get-current-string.scm"))))
