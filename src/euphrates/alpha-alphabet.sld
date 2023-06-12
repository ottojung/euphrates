
(define-library
  (euphrates alpha-alphabet)
  (export alpha/alphabet)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/alpha-alphabet.scm")))
    (else (include "alpha-alphabet.scm"))))
