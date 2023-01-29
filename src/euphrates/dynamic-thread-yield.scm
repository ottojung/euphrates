
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-yield)
    :export (dynamic-thread-yield)
    :use-module ((euphrates dynamic-thread-yield-p) :select (dynamic-thread-yield#p))
    :use-module ((euphrates dynamic-thread-yield-p-default) :select (dynamic-thread-yield#p-default)))))



(define (dynamic-thread-yield)
  ((or (dynamic-thread-yield#p)
       dynamic-thread-yield#p-default)))
