
(cond-expand
 (guile
  (define-module (euphrates date-get-current-time24h-string)
    :export (date-get-current-time24h-string)
    :use-module ((euphrates date-get-current-string) :select (date-get-current-string)))))



(define (date-get-current-time24h-string)
  (date-get-current-string "~H:~M:~S"))
