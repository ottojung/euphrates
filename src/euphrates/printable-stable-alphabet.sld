
(define-library
  (euphrates printable-stable-alphabet)
  (export printable/stable/alphabet)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/printable-stable-alphabet.scm")))
    (else (include "printable-stable-alphabet.scm"))))
