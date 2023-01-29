
(cond-expand
 (guile
  (define-module (euphrates time-get-current-unixtime-values-p-default)
    :export (#{time-get-current-unixtime/values#p-default}#))))


(cond-expand
 (guile

  (use-modules (srfi srfi-19))

  (define (time-get-current-unixtime/values#p-default)
    (let ((time (current-time time-utc)))
      (values (time-second time) (time-nanosecond time))))

  ))


