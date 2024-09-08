
(define-library
  (euphrates parselynn-get-compilation-environment)
  (export parselynn:get-compilation-environment)
  (import
    (only (euphrates parselynn-compilation-environment-p)
          parselynn:compilation-environment/p))
  (import
    (only (euphrates
            parselynn-default-compilation-environment)
          parselynn:default-compilation-environment))
  (import (only (scheme base) begin define or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-get-compilation-environment.scm")))
    (else (include
            "parselynn-get-compilation-environment.scm"))))
