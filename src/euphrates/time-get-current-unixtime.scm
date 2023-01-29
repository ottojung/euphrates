
(cond-expand
 (guile
  (define-module (euphrates time-get-current-unixtime)
    :export (time-get-current-unixtime time-get-current-unixtime/values)
    :use-module ((euphrates time-get-current-unixtime-values-p) :select (time-get-current-unixtime/values#p))
    :use-module ((euphrates time-get-current-unixtime-values-p-default) :select (time-get-current-unixtime/values#p-default))
    :use-module ((euphrates unit-conversions) :select (nano->normal/unit)))))

;; Calculates current unixtime UTC
;;
;; @returns Fraction, where integer part is seconds


(define (time-get-current-unixtime/values)
  ((or (time-get-current-unixtime/values#p)
       time-get-current-unixtime/values#p-default)))

(define (time-get-current-unixtime)
  (define-values (second nanosecond) (time-get-current-unixtime/values))
  (exact->inexact
   (+ second (nano->normal/unit nanosecond))))
