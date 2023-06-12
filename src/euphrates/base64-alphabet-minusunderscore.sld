
(define-library
  (euphrates base64-alphabet-minusunderscore)
  (export base64/alphabet/minusunderscore)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/base64-alphabet-minusunderscore.scm")))
    (else (include "base64-alphabet-minusunderscore.scm"))))
