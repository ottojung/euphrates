
(define (call-with-output-string fun)
  (define q (open-output-string))
  (fun q)
  (let ((r (get-output-string q)))
    (close-port q)
    r))
