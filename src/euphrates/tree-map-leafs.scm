


(define (tree-map-leafs fn T)
  (let loop ((T T))
    (if (list? T)
        (map loop T)
        (fn T))))

