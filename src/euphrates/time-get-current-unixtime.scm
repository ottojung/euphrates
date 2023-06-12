

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
