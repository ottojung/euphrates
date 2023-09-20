
(define-library
  (euphrates
    lalr-lexer-singlechar-run-on-char-port)
  (export lalr-lexer/singlechar:run-on-char-port)
  (import
    (only (euphrates lalr-lexer-singlechar-start)
          lalr-lexer/singlechar-start))
  (import (only (scheme base) begin define quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-lexer-singlechar-run-on-char-port.scm")))
    (else (include
            "lalr-lexer-singlechar-run-on-char-port.scm"))))
