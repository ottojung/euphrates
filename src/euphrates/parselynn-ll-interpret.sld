
(define-library
  (euphrates parselynn-ll-interpret)
  (export parselynn:ll-interpret)
  (import
    (only (euphrates parselynn-get-compilation-environment)
          parselynn:get-compilation-environment))
  (import
    (only (euphrates parselynn-ll-1-compile)
          parselynn:ll-1-compile))
  (import (only (scheme base) begin define))
  (import (only (scheme eval) eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-ll-interpret.scm")))
    (else (include "parselynn-ll-interpret.scm"))))
