
(define-library
  (euphrates least-common-multiple)
  (export least-common-multiple)
  (import
    (only (euphrates greatest-common-divisor)
          greatest-common-divisor))
  (import
    (only (scheme base) * / = abs begin define if or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/least-common-multiple.scm")))
    (else (include "least-common-multiple.scm"))))
