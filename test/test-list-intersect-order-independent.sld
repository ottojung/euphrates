
(define-library
  (test-list-intersect-order-independent)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates list-intersect-order-independent)
          list-intersect/order-independent))
  (import (only (scheme base) begin quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-list-intersect-order-independent.scm")))
    (else (include
            "test-list-intersect-order-independent.scm"))))
