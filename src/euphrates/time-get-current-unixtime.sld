
(define-library
  (euphrates time-get-current-unixtime)
  (export
    time-get-current-unixtime
    time-get-current-unixtime/values)
  (import
    (only (euphrates
            time-get-current-unixtime-values-p-default)
          #{time-get-current-unixtime/values#p-default}#)
    (only (euphrates time-get-current-unixtime-values-p)
          #{time-get-current-unixtime/values#p}#)
    (only (euphrates unit-conversions)
          nano->normal/unit)
    (only (scheme base)
          +
          begin
          define
          define-values
          or)
    (only (scheme r5rs) exact->inexact)
    (only (srfi srfi-1) second))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/time-get-current-unixtime.scm")))
    (else (include "time-get-current-unixtime.scm"))))
