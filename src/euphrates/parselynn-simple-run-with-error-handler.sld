
(define-library
  (euphrates
    parselynn-simple-run-with-error-handler)
  (export
    parselynn/simple:run/with-error-handler)
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
               "euphrates/parselynn-simple-run-with-error-handler.scm")))
    (else (include
            "parselynn-simple-run-with-error-handler.scm"))))
