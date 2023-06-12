



(define (dynamic-thread-get-delay-procedure)
  (let ((p (dynamic-thread-get-delay-procedure#p)))
    (if p (p)
        (dynamic-thread-get-delay-procedure#p-default))))
