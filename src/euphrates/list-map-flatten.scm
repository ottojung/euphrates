


(define (list-map/flatten f L)
  (apply append (map f L)))
