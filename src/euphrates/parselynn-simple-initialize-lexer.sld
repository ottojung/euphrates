
(define-library
  (euphrates parselynn-simple-initialize-lexer)
  (export parselynn/simple:initialize-lexer)
  (import
    (only (euphrates
            parselynn-fohomomorph-result-as-iterator)
          parselynn/fohomomorph-result:as-iterator))
  (import
    (only (euphrates
            parselynn-fohomomorph-run-on-char-port)
          parselynn/fohomomorph:run-on-char-port))
  (import
    (only (euphrates parselynn-fohomomorph-run-on-string)
          parselynn/fohomomorph:run-on-string))
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
