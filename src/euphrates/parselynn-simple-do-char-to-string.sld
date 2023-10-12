
(define-library
  (euphrates parselynn-simple-do-char-to-string)
  (export parselynn/simple-do-char->string)
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
               "euphrates/parselynn-simple-do-char-to-string.scm")))
    (else (include
            "parselynn-simple-do-char-to-string.scm"))))
