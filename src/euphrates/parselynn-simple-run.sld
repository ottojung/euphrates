
(define-library
  (euphrates parselynn-simple-run)
  (export parselynn/simple:run)
  (import
    (only (euphrates
            parselynn-simple-run-with-error-handler)
          parselynn/simple:run/with-error-handler))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base) begin define list quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-run.scm")))
    (else (include "parselynn-simple-run.scm"))))
