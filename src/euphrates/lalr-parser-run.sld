
(define-library
  (euphrates lalr-parser-run)
  (export lalr-parser-run)
  (import
    (only (euphrates lalr-parser-run-with-error-handler)
          lalr-parser-run/with-error-handler))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base) begin define list quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-run.scm")))
    (else (include "lalr-parser-run.scm"))))
