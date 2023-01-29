
%run guile

%var time-get-current-unixtime/values#p-default

%for (COMPILER "guile")

(use-modules (srfi srfi-19))

(define (time-get-current-unixtime/values#p-default)
  (let ((time (current-time time-utc)))
    (values (time-second time) (time-nanosecond time))))

%end


