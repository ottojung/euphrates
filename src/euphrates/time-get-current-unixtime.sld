
(define-library
  (euphrates time-get-current-unixtime)
  (export
    time-get-current-unixtime
    time-get-current-unixtime/values)
  (import
    (only (euphrates
           time-get-current-unixtime-values-p-default)
          time-get-current-unixtime/values#p-default))
  (import
    (only (euphrates time-get-current-unixtime-values-p)
          #{time-get-current-unixtime/values#p}#))
  (import
    (only (euphrates unit-conversions)
          nano->normal/unit))
  (import
    (only (scheme base)
          +
          begin
          define
          define-values
          or))
  (import (only (scheme r5rs) exact->inexact))
  (cond-expand
    (guile (import (only (srfi srfi-1) second)))
    (else (import (only (srfi 1) second))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/time-get-current-unixtime.scm")))
    (else (include "time-get-current-unixtime.scm"))))
