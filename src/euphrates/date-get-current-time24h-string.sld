
(define-library
  (euphrates date-get-current-time24h-string)
  (export date-get-current-time24h-string)
  (import
    (only (euphrates date-get-current-string)
          date-get-current-string)
    (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/date-get-current-time24h-string.scm")))
    (else (include "date-get-current-time24h-string.scm"))))
