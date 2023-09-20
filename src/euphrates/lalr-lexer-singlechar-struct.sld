
(define-library
  (euphrates lalr-lexer-singlechar-struct)
  (export
    make-lalr-lexer/singlechar-struct
    lalr-lexer/singlechar-struct?
    lalr-lexer/singlechar-struct:additional-grammar-rules
    lalr-lexer/singlechar-struct:lexer/port
    lalr-lexer/singlechar-struct:lexer/string)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-lexer-singlechar-struct.scm")))
    (else (include "lalr-lexer-singlechar-struct.scm"))))
