
(define-library
  (euphrates alpha-lowercase-alphabet)
  (export alpha-lowercase/alphabet)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/alpha-lowercase-alphabet.scm")))
    (else (include "alpha-lowercase-alphabet.scm"))))
