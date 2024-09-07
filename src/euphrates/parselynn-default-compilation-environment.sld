
(define-library
  (euphrates
    parselynn-default-compilation-environment)
  (export
    parselynn:default-compilation-environment)
  (import (only (scheme base) begin define quote))
  (import (only (scheme eval) environment))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-default-compilation-environment.scm")))
    (else (include
            "parselynn-default-compilation-environment.scm"))))
