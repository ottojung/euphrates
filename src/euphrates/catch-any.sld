
(define-library
  (euphrates catch-any)
  (export catch-any)
  (import (only (scheme base) begin define guard))
  (cond-expand
    (guile (import (only (srfi srfi-35) condition)))
    (else (import (only (srfi 35) condition))))
  (cond-expand
    (guile (import (only (guile) include-from-path catch))
           (begin
             (include-from-path "euphrates/catch-any.scm")))
    (else (include "catch-any.scm"))))
