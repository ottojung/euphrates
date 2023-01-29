
%run guile

;; Calculates current unixtime UTC
;;
;; @returns Fraction, where integer part is seconds
%var time-get-current-unixtime
%var time-get-current-unixtime/values

%use (time-get-current-unixtime/values#p) "./time-get-current-unixtime-values-p.scm"
%use (time-get-current-unixtime/values#p-default) "./time-get-current-unixtime-values-p-default.scm"
%use (nano->normal/unit) "./unit-conversions.scm"

(define (time-get-current-unixtime/values)
  ((or (time-get-current-unixtime/values#p)
       time-get-current-unixtime/values#p-default)))

(define (time-get-current-unixtime)
  (define-values (second nanosecond) (time-get-current-unixtime/values))
  (exact->inexact
   (+ second (nano->normal/unit nanosecond))))
