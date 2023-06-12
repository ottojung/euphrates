
(define-library
  (test-date-get-current-time24h-string)
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-date-get-current-time24h-string.scm")))
    (else (include
            "test-date-get-current-time24h-string.scm"))))
