
(define-library
  (euphrates current-random-source-p)
  (export current-random-source/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/current-random-source-p.scm")))
    (else (include "current-random-source-p.scm"))))
