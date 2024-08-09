
(define-library
  (euphrates parselynn-epsilon)
  (export parselynn:epsilon)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-epsilon.scm")))
    (else (include "parselynn-epsilon.scm"))))
