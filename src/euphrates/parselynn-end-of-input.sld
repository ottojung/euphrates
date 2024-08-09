
(define-library
  (euphrates parselynn-end-of-input)
  (export parselynn:end-of-input)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-end-of-input.scm")))
    (else (include "parselynn-end-of-input.scm"))))
