
(define-library
  (euphrates ignore)
  (export ignore)
  (import (only (scheme base) begin define when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/ignore.scm")))
    (else (include "ignore.scm"))))
