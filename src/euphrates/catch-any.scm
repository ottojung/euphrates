
(define (catch-any body handler)
  (guard
   (condition
    (#t (handler condition)))
   (body)))
