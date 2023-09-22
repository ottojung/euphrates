
(define-library
  (euphrates
    lalr-parser-simple-run-with-error-handler)
  (export
    lalr-parser/simple:run/with-error-handler)
  (import
    (only (euphrates lalr-parser-run-with-error-handler)
          lalr-parser-run/with-error-handler))
  (import
    (only (euphrates lalr-parser-simple-postprocess)
          lalr-parser/simple:postprocess))
  (import
    (only (euphrates lalr-parser-simple-initialize-lexer)
          lalr-parser/simple:initialize-lexer))
  (import
    (only (euphrates lalr-parser-simple-struct)
          lalr-parser/simple-struct:backend-parser))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-simple-run-with-error-handler.scm")))
    (else (include
            "lalr-parser-simple-run-with-error-handler.scm"))))
