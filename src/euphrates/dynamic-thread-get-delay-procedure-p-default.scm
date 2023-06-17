



(define (dynamic-thread-get-delay-procedure/p-default)
  (let ((timeout (dynamic-thread-get-wait-delay))
        (sleep (or (dynamic-thread-sleep/p) dynamic-thread-sleep)))
    (lambda _
      (sleep timeout))))
