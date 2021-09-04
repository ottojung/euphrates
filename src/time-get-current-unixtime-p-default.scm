
%run guile

%var time-get-current-unixtime#p-default

%for (COMPILER "guile")

%use (nano->normal/unit) "./unit-conversions.scm"

(use-modules (srfi srfi-19))

(define (time-get-current-unixtime#p-default)
  (let ((time (current-time time-utc)))
    (+ (time-second time)
       (nano->normal/unit (time-nanosecond time)))))

%end


