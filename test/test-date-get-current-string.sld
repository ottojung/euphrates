
(define-library
  (test-date-get-current-string)
  (import (only (scheme base) begin cond-expand))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-date-get-current-string.scm")))
    (else (include "test-date-get-current-string.scm"))))
