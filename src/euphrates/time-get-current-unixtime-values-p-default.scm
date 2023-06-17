
(define (time-get-current-unixtime/values/p-default)
  (let ((time (current-time time-utc)))
    (values (time-second time) (time-nanosecond time))))
