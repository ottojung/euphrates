
(define-library
  (euphrates lalr-parser-simple-do-char-to-string)
  (export lalr-parser/simple-do-char->string)
  (import
    (only (scheme base)
          begin
          char?
          cond
          define
          else
          let
          list?
          map
          string))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-simple-do-char-to-string.scm")))
    (else (include
            "lalr-parser-simple-do-char-to-string.scm"))))
