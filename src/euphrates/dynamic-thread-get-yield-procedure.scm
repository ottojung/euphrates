
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-get-yield-procedure)
    :export (dynamic-thread-get-yield-procedure)
    :use-module ((euphrates dynamic-thread-yield-p) :select (dynamic-thread-yield#p)))))



(define (dynamic-thread-get-yield-procedure)
  (dynamic-thread-yield#p))

