
(define-library
  (euphrates radix3)
  (export
    radix3:constructor
    radix3?
    radix3:sign
    radix3:intpart
    radix3:fracpart
    radix3:period
    radix3:basevector)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/radix3.scm")))
    (else (include "radix3.scm"))))
