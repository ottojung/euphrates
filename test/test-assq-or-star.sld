
(define-library
  (test-assq-or-star)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assq-or-star) assq-or*))
  (import
    (only (scheme base) begin cond-expand quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-assq-or-star.scm")))
    (else (include "test-assq-or-star.scm"))))
