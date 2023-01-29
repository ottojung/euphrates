
(cond-expand
 (guile
  (define-module (euphrates time-to-string)
    :export (seconds->M/s seconds->H/M/s seconds->time-string)
    :use-module ((euphrates string-pad) :select (string-pad-L)))))



(define (seconds->M/s seconds0)
  (define seconds (remainder seconds0 60))
  (define minutes0 (quotient seconds0 60))
  (values minutes0 seconds))

(define (seconds->H/M/s seconds0)
  (define-values (minutes0 seconds)
    (seconds->M/s seconds0))
  (define minutes (remainder minutes0 60))
  (define hours0 (quotient minutes0 60))
  (values hours0 minutes seconds))

(define (seconds->time-string seconds0)
  (define-values (hours minutes seconds)
    (seconds->H/M/s seconds0))

  (string-append
   (number->string hours) ":"
   (string-pad-L (number->string minutes) 2 #\0) ":"
   (string-pad-L (number->string seconds) 2 #\0)))

;; TODO: other conversions
