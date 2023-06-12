
(define-library
  (euphrates alist-initialize-bang-p)
  (export alist-initialize!/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/alist-initialize-bang-p.scm")))
    (else (include "alist-initialize-bang-p.scm"))))
