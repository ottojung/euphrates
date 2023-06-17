
(define-library
  (euphrates time-to-string)
  (export
    seconds->M/s
    seconds->H/M/s
    seconds->time-string)
  (import
    (only (euphrates string-pad) string-pad-L))
  (import
    (only (scheme base)
          begin
          define
          define-values
          number->string
          quotient
          remainder
          string-append
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/time-to-string.scm")))
    (else (include "time-to-string.scm"))))
