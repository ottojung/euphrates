
(define-library
  (euphrates string-to-numstring)
  (export string->numstring)
  (import
    (only (euphrates list-intersperse)
          list-intersperse)
    (only (scheme base)
          apply
          begin
          char->integer
          cons
          define
          map
          number->string
          string->list
          string-append))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/string-to-numstring.scm")))
    (else (include "string-to-numstring.scm"))))
