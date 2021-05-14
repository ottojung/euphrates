
%run guile

;; Calculates current unixtime UTC
;;
;; @returns Fraction, where integer part is seconds
%var time-get-current-unixtime

%for (COMPILER "guile")

%use (nano->normal/unit) "./unit-conversions.scm"

(use-modules (srfi srfi-19))

(define (time-get-current-unixtime)
  (let ((time (current-time time-utc)))
    (+ (time-second time)
       (nano->normal/unit (time-nanosecond time)))))

%end


