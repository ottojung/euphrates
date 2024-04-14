
(define-library
  (euphrates
    parselynn-fohomomorph-run-on-char-port)
  (export parselynn:fohomomorph:run-on-char-port)
  (import
    (only (euphrates parselynn-fohomomorph-result-struct)
          make-parselynn:fohomomorph-result-struct))
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-fohomomorph-run-on-char-port.scm")))
    (else (include
            "parselynn-fohomomorph-run-on-char-port.scm"))))
