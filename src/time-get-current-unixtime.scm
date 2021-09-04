
%run guile

;; Calculates current unixtime UTC
;;
;; @returns Fraction, where integer part is seconds
%var time-get-current-unixtime

%use (time-get-current-unixtime#p) "./time-get-current-unixtime-p.scm"
%use (time-get-current-unixtime#p-default) "./time-get-current-unixtime-p-default.scm"

(define (time-get-current-unixtime)
  ((or (time-get-current-unixtime#p)
       time-get-current-unixtime#p-default)))
