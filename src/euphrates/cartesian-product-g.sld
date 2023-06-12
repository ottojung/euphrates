
(define-library
  (euphrates cartesian-product-g)
  (export
    cartesian-product/g/reversed
    cartesian-product/g)
  (import
    (only (euphrates cartesian-map) cartesian-map)
    (only (euphrates cartesian-product)
          cartesian-product)
    (only (scheme base)
          begin
          cadr
          car
          cddr
          cdr
          cond
          define
          else
          if
          let
          list
          map
          null?
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/cartesian-product-g.scm")))
    (else (include "cartesian-product-g.scm"))))
