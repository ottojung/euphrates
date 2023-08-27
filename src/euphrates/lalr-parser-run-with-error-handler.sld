
(define-library
  (euphrates lalr-parser-run-with-error-handler)
  (export lalr-parser-run/with-error-handler)
  (import
    (only (euphrates lalr-parser-struct)
          lalr-parser-struct:actions
          lalr-parser-struct:code
          lalr-parser-struct:maybefun))
  (import
    (only (scheme base) begin define if let quote))
  (import (only (scheme eval) environment eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-run-with-error-handler.scm")))
    (else (include
            "lalr-parser-run-with-error-handler.scm"))))
