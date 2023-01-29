
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-mutex-lock)
    :export (dynamic-thread-mutex-lock!)
    :use-module ((euphrates dynamic-thread-mutex-lock-p) :select (dynamic-thread-mutex-lock!#p))
    :use-module ((euphrates dynamic-thread-mutex-lock-p-default) :select (dynamic-thread-mutex-lock!#p-default)))))



(define (dynamic-thread-mutex-lock! mut)
  ((or (dynamic-thread-mutex-lock!#p)
       dynamic-thread-mutex-lock!#p-default) mut))
