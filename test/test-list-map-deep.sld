
(define-library
  (test-list-map-deep)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import (only (euphrates const) const))
  (import
    (only (euphrates list-map-deep) list-map/deep))
  (import
    (only (scheme base)
          *
          +
          begin
          cons
          lambda
          list
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-map-deep.scm")))
    (else (include "test-list-map-deep.scm"))))
