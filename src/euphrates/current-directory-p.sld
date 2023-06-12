
(define-library
  (euphrates current-directory-p)
  (export current-directory/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/current-directory-p.scm")))
    (else (include "current-directory-p.scm"))))
