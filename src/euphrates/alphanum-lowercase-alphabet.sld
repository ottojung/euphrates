
(define-library
  (euphrates alphanum-lowercase-alphabet)
  (export alphanum-lowercase/alphabet)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/alphanum-lowercase-alphabet.scm")))
    (else (include "alphanum-lowercase-alphabet.scm"))))
