
(cond-expand
 (guile
  (define-module (euphrates list-map-flatten)
    :export (list-map/flatten))))


(define (list-map/flatten f L)
  (apply append (map f L)))
