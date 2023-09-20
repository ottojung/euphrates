
(define-library
  (euphrates
    lalr-lexer-singlechar-result-as-iterator)
  (export lalr-lexer/singlechar-result:as-iterator)
  (import
    (only (euphrates lalr-lexer-singlechar-result-struct)
          lalr-lexer/singlechar-result-struct:continuation))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-lexer-singlechar-result-as-iterator.scm")))
    (else (include
            "lalr-lexer-singlechar-result-as-iterator.scm"))))
