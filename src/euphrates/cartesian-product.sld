
(define-library
  (euphrates cartesian-product)
  (export cartesian-product)
  (import
    (only (euphrates cartesian-map) cartesian-map))
  (import (only (scheme base) begin cons define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/cartesian-product.scm")))
    (else (include "cartesian-product.scm"))))
