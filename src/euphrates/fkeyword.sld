
(define-library
  (euphrates fkeyword)
  (export
    fkeyword
    fkeyword?
    fkeyword->string
    string->fkeyword
    looks-like-an-unquoted-fkeyword?)
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (scheme base)
          -
          >
          and
          begin
          char=?
          define
          if
          let
          let*
          list
          quote
          string->symbol
          string-append
          string-length
          string-ref
          substring
          symbol->string
          symbol?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/fkeyword.scm")))
    (else (include "fkeyword.scm"))))
