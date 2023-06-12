



(cond-expand
 (guile

  (define (date-get-current-string format-string)
    ;; (define time (current-time))
    (define-values (u-second u-nanosecond) (time-get-current-unixtime/values))
    (define time (make-time 'time-utc u-nanosecond u-second))
    (define date (time-utc->date time))
    (date->string date format-string))

  ))
