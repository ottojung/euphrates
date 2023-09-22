
(define-library
  (euphrates lalr-parser-simple-run)
  (export lalr-parser/simple:run)
  (import
    (only (euphrates lalr-parser-run-with-error-handler)
          lalr-parser-run/with-error-handler))
  (import
    (only (euphrates lalr-parser-simple-common-run)
          lalr-parser/simple:common-run))
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
               "euphrates/lalr-parser-simple-run.scm")))
    (else (include "lalr-parser-simple-run.scm"))))
