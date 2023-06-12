
(define (call-with-input-string str fun)
  (define q (open-input-string str))
  (call-with-values
      (lambda _ (fun q))
    (lambda vals
      (close-port q)
      (apply values vals))))
