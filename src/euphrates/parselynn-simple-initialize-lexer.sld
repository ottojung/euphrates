
(define-library
  (euphrates parselynn-simple-initialize-lexer)
  (export parselynn/simple:initialize-lexer)
  (import
    (only (euphrates
            parselynn-singlechar-result-as-iterator)
          parselynn/singlechar-result:as-iterator))
  (import
    (only (euphrates
            parselynn-singlechar-run-on-char-port)
          parselynn/singlechar:run-on-char-port))
  (import
    (only (euphrates parselynn-singlechar-run-on-string)
          parselynn/singlechar:run-on-string))
  (import
    (only (euphrates parselynn-simple-struct)
          parselynn/simple-struct:lexer))
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
               "euphrates/parselynn-simple-initialize-lexer.scm")))
    (else (include
            "parselynn-simple-initialize-lexer.scm"))))
