
(define (printf fmt . args)
  (display (apply stringf (cons fmt args))))
