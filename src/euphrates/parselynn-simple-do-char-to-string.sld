
(define-library
  (euphrates parselynn-simple-do-char-to-string)
  (export parselynn:simple:do-char->string)
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
               "euphrates/parselynn-simple-do-char-to-string.scm")))
    (else (include
            "parselynn-simple-do-char-to-string.scm"))))
