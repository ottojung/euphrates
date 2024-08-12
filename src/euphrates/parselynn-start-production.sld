
(define-library
  (euphrates parselynn-start-production)
  (export parselynn:start-production)
  (import
    (only (euphrates unique-identifier)
          make-unique-identifier))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-start-production.scm")))
    (else (include "parselynn-start-production.scm"))))
