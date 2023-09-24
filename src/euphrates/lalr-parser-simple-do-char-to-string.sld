
(define-library
  (euphrates lalr-parser-simple-do-char-to-string)
  (export lalr-parser/simple-do-char->string)
  (import (only (euphrates hashset) hashset-has?))
  (import
    (only (scheme base)
          and
          apply
          begin
          car
          cdr
          char?
          cond
          define
          else
          if
          let
          list?
          map
          pair?
          string))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-parser-simple-do-char-to-string.scm")))
    (else (include
            "lalr-parser-simple-do-char-to-string.scm"))))
