
(define-library
  (euphrates lalr-lexer-latin-letters)
  (export lalr-lexer/latin/letters)
  (import
    (only (euphrates lalr-lexer-latin-lowercases)
          lalr-lexer/latin/lowercases))
  (import
    (only (euphrates lalr-lexer-latin-uppercases)
          lalr-lexer/latin/uppercases))
  (import (only (scheme base) append begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-lexer-latin-letters.scm")))
    (else (include "lalr-lexer-latin-letters.scm"))))
