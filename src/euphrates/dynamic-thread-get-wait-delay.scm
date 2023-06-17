



(define (dynamic-thread-get-wait-delay)
  (or (dynamic-thread-wait-delay/us/p)
      dynamic-thread-wait-delay/us/p-default))
