
(define-library
  (euphrates parselynn-fohomomorph-run-on-string)
  (export parselynn:fohomomorph:run-on-string)
  (import
    (only (euphrates parselynn-fohomomorph-result-struct)
          make-parselynn:fohomomorph-result-struct))
  (import
    (only (scheme base) begin define quote string))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-fohomomorph-run-on-string.scm")))
    (else (include
            "parselynn-fohomomorph-run-on-string.scm"))))
