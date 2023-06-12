
(define-library
  (euphrates printable-alphabet)
  (export printable/alphabet)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/printable-alphabet.scm")))
    (else (include "printable-alphabet.scm"))))
