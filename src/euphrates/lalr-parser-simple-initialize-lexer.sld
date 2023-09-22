
(define-library
  (euphrates lalr-parser-simple-initialize-lexer)
  (export lalr-parser/simple:initialize-lexer)
  (import
    (only (euphrates
            lalr-lexer-singlechar-result-as-iterator)
          lalr-lexer/singlechar-result:as-iterator))
  (import
    (only (euphrates
            lalr-lexer-singlechar-run-on-char-port)
          lalr-lexer/singlechar:run-on-char-port))
  (import
    (only (euphrates lalr-lexer-singlechar-run-on-string)
          lalr-lexer/singlechar:run-on-string))
  (import
    (only (euphrates lalr-parser-simple-struct)
          lalr-parser/simple-struct:lexer))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (scheme base)
          begin
          cond
          define
          else
          list
          port?
          quote
          string?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-simple-initialize-lexer.scm")))
    (else (include
            "lalr-parser-simple-initialize-lexer.scm"))))
