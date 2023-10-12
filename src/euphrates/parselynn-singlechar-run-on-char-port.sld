
(define-library
  (euphrates
    parselynn-singlechar-run-on-char-port)
  (export parselynn/singlechar:run-on-char-port)
  (import
    (only (euphrates parselynn-singlechar-result-struct)
          make-parselynn/singlechar-result-struct))
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-singlechar-run-on-char-port.scm")))
    (else (include
            "parselynn-singlechar-run-on-char-port.scm"))))
