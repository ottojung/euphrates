



(define (dynamic-thread-mutex-unlock! mut)
  ((or (dynamic-thread-mutex-unlock!/p)
       dynamic-thread-mutex-unlock!/p-default) mut))
