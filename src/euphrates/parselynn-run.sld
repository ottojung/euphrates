
(define-library
  (euphrates parselynn-run)
  (export parselynn-run)
  (import
    (only (euphrates parselynn-run-with-error-handler)
          parselynn-run/with-error-handler))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base) begin define list quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-run.scm")))
    (else (include "parselynn-run.scm"))))
