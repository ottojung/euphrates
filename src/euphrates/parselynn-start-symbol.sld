
(define-library
  (euphrates parselynn-start-symbol)
  (export parselynn:start-symbol)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-start-symbol.scm")))
    (else (include "parselynn-start-symbol.scm"))))
