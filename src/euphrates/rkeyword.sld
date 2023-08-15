
(define-library
  (euphrates rkeyword)
  (export
    rkeyword
    rkeyword?
    rkeyword->string
    string->rkeyword
    looks-like-an-unquoted-rkeyword?)
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (scheme base)
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
             (include-from-path "euphrates/rkeyword.scm")))
    (else (include "rkeyword.scm"))))
