
(define-library
  (euphrates
    lalr-lexer-singlechar-run-on-char-port)
  (export lalr-lexer/singlechar:run-on-char-port)
  (import
    (only (euphrates lalr-lexer-singlechar-struct)
          lalr-lexer/singlechar-struct:lexer/port))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-lexer-singlechar-run-on-char-port.scm")))
    (else (include
            "lalr-lexer-singlechar-run-on-char-port.scm"))))
