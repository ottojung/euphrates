
(define (negate proc)
  (lambda args
    (not (apply proc args))))
