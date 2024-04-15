
(define-library
  (euphrates parselynn-folexer-run-on-char-port)
  (export parselynn:folexer:run-on-char-port)
  (import
    (only (euphrates parselynn-folexer-result-struct)
          make-parselynn:folexer-result-struct))
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-folexer-run-on-char-port.scm")))
    (else (include
            "parselynn-folexer-run-on-char-port.scm"))))
