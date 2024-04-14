
(define-library
  (euphrates parselynn-folexer-run-on-string)
  (export parselynn:folexer:run-on-string)
  (import
    (only (euphrates parselynn-folexer-result-struct)
          make-parselynn:folexer-result-struct))
  (import
    (only (scheme base) begin define quote string))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-folexer-run-on-string.scm")))
    (else (include
            "parselynn-folexer-run-on-string.scm"))))
