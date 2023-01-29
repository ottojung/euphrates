
(cond-expand
 (guile
  (define-module (euphrates date-get-current-string)
    :export (date-get-current-string)
    :use-module ((euphrates time-get-current-unixtime) :select (time-get-current-unixtime/values)))))



(cond-expand
 (guile

  (use-modules (srfi srfi-19))

  (define (date-get-current-string format-string)
    ;; (define time (current-time))
    (define-values (u-second u-nanosecond) (time-get-current-unixtime/values))
    (define time (make-time 'time-utc u-nanosecond u-second))
    (define date (time-utc->date time))
    (date->string date format-string))

  ))
