



(define (dynamic-thread-spawn thunk)
  ((or (dynamic-thread-spawn#p)
       (raisu 'threading-system-is-not-parameterized)) thunk))
