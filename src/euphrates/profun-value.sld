
(define-library
  (euphrates profun-value)
  (export
    profun-unbound-value?
    profun-bound-value?
    profun-value-unwrap
    profun-value-name
    profun-value?
    profun-make-var
    profun-make-constant
    profun-make-unbound-var)
  (import
    (only (euphrates define-type9) define-type9)
    (only (scheme base) and begin define if not))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/profun-value.scm")))
    (else (include "profun-value.scm"))))
