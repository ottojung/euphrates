
(cond-expand
 (guile
  (define-module (euphrates tree-map-leafs)
    :export (tree-map-leafs))))


(define (tree-map-leafs fn T)
  (let loop ((T T))
    (if (list? T)
        (map loop T)
        (fn T))))

