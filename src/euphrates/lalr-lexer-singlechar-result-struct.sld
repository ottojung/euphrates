
(define-library
  (euphrates lalr-lexer-singlechar-result-struct)
  (export
    make-lalr-lexer/singlechar-result-struct
    lalr-lexer/singlechar-result-struct?
    lalr-lexer/singlechar-result-struct:continuation)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-lexer-singlechar-result-struct.scm")))
    (else (include
            "lalr-lexer-singlechar-result-struct.scm"))))
