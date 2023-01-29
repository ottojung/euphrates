
(cond-expand
 (guile
  (define-module (euphrates dynamic-thread-mutex-unlock)
    :export (dynamic-thread-mutex-unlock!)
    :use-module ((euphrates dynamic-thread-mutex-unlock-p) :select (dynamic-thread-mutex-unlock!#p))
    :use-module ((euphrates dynamic-thread-mutex-unlock-p-default) :select (dynamic-thread-mutex-unlock!#p-default)))))



(define (dynamic-thread-mutex-unlock! mut)
  ((or (dynamic-thread-mutex-unlock!#p)
       dynamic-thread-mutex-unlock!#p-default) mut))
