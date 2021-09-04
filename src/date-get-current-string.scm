
%run guile

%var date-get-current-string

%use (time-get-current-unixtime/values) "./time-get-current-unixtime.scm"

%for (COMPILER "guile")

(use-modules (srfi srfi-19))

(define (date-get-current-string format-string)
  ;; (define time (current-time))
  (define-values (u-second u-nanosecond) (time-get-current-unixtime/values))
  (define time (make-time 'time-utc u-nanosecond u-second))
  (define date (time-utc->date time))
  (date->string date format-string))

%end
