



(define (dynamic-thread-mutex-make)
  ((or (dynamic-thread-mutex-make#p)
       dynamic-thread-mutex-make#p-default)))
