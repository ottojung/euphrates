
(define (compose proc . rest)
  (if (null? rest)
      proc
      (let ((g (apply compose rest)))
        (lambda args
          (call-with-values (lambda () (apply g args)) proc)))))
