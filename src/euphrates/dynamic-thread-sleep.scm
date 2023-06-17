



(define (dynamic-thread-sleep us)
  ((or (dynamic-thread-sleep/p)
       dynamic-thread-sleep/p-default) us))

