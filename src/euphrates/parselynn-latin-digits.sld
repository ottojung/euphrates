
(define-library
  (euphrates parselynn-latin-digits)
  (export parselynn/latin/digits)
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-latin-digits.scm")))
    (else (include "parselynn-latin-digits.scm"))))
