
(define-library
  (euphrates current-program-path-p)
  (export current-program-path/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/current-program-path-p.scm")))
    (else (include "current-program-path-p.scm"))))
