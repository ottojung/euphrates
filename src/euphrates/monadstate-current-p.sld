
(define-library
  (euphrates monadstate-current-p)
  (export monadstate-current/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/monadstate-current-p.scm")))
    (else (include "monadstate-current-p.scm"))))
