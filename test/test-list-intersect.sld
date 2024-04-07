
(define-library
  (test-list-intersect)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates list-intersect) list-intersect))
  (import (only (scheme base) begin quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-intersect.scm")))
    (else (include "test-list-intersect.scm"))))
