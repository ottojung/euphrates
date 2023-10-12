
(define-library
  (euphrates parselynn-latin-uppercases)
  (export parselynn/latin/uppercases)
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-latin-uppercases.scm")))
    (else (include "parselynn-latin-uppercases.scm"))))
