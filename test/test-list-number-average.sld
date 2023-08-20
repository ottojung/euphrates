
(define-library
  (test-list-number-average)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-number-average)
          list-number-average))
  (import (only (scheme base) begin quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-list-number-average.scm")))
    (else (include "test-list-number-average.scm"))))
