
(define-library
  (euphrates parselynn-simple-run)
  (export parselynn/simple:run)
  (import
    (only (euphrates parselynn-run-with-error-handler)
          parselynn-run/with-error-handler))
  (import
    (only (euphrates parselynn-simple-postprocess)
          parselynn/simple:postprocess))
  (import
    (only (euphrates parselynn-simple-initialize-lexer)
          parselynn/simple:initialize-lexer))
  (import
    (only (euphrates parselynn-simple-struct)
          parselynn/simple-struct:backend-parser))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-simple-run.scm")))
    (else (include "parselynn-simple-run.scm"))))
