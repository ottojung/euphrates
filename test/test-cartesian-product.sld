
(define-library
  (test-cartesian-product)
  (import
    (only (euphrates assert-equal-hs) assert=HS))
  (import
    (only (euphrates cartesian-product)
          cartesian-product))
  (import
    (only (scheme base) begin cond-expand let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-cartesian-product.scm")))
    (else (include "test-cartesian-product.scm"))))
