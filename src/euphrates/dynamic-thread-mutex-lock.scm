



(define (dynamic-thread-mutex-lock! mut)
  ((or (dynamic-thread-mutex-lock!/p)
       dynamic-thread-mutex-lock!/p-default) mut))
