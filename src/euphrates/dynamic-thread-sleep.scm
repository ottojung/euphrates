
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-sleep)
    :export (dynamic-thread-sleep)
    :use-module ((euphrates dynamic-thread-sleep-p) :select (dynamic-thread-sleep#p))
    :use-module ((euphrates dynamic-thread-sleep-p-default) :select (dynamic-thread-sleep#p-default)))))



(define (dynamic-thread-sleep us)
  ((or (dynamic-thread-sleep#p)
       dynamic-thread-sleep#p-default) us))

