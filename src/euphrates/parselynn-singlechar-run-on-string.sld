
(define-library
  (euphrates parselynn-singlechar-run-on-string)
  (export parselynn/singlechar:run-on-string)
  (import
    (only (euphrates parselynn-singlechar-result-struct)
          make-parselynn/singlechar-result-struct))
  (import
    (only (scheme base) begin define quote string))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-singlechar-run-on-string.scm")))
    (else (include
            "parselynn-singlechar-run-on-string.scm"))))
