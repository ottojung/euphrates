
(cond-expand
 (guile
  (define-module (euphrates cartesian-product)
    :export (cartesian-product)
    :use-module ((euphrates cartesian-map) :select (cartesian-map)))))



(define (cartesian-product a b)
  (cartesian-map cons a b))
