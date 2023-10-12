
(define-library
  (euphrates parselynn-latin-lowercases)
  (export parselynn/latin/lowercases)
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-latin-lowercases.scm")))
    (else (include "parselynn-latin-lowercases.scm"))))
