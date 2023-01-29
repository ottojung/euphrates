
(cond-expand
 (guile
  (define-module (euphrates string-take-n)
    :export (string-take-n))))


(define (string-take-n n str)
  (substring str 0 (min (max 0 n) (string-length str))))
