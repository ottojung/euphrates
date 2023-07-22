
(define-library
  (test-assq-set-value-star)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assq-set-value-star)
          assq-set-value*))
  (import
    (only (scheme base) begin cond-expand not quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-assq-set-value-star.scm")))
    (else (include "test-assq-set-value-star.scm"))))
