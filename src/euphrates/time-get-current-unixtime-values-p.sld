
(define-library
  (euphrates time-get-current-unixtime-values-p)
  (export #{time-get-current-unixtime/values#p}#)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/time-get-current-unixtime-values-p.scm")))
    (else (include
            "time-get-current-unixtime-values-p.scm"))))
