
(define-library
  (euphrates base64-alphabet)
  (export base64/alphabet)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/base64-alphabet.scm")))
    (else (include "base64-alphabet.scm"))))
