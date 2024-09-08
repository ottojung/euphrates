
(define-library
  (euphrates parselynn-compilation-environment-p)
  (export parselynn:compilation-environment/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-compilation-environment-p.scm")))
    (else (include
            "parselynn-compilation-environment-p.scm"))))
