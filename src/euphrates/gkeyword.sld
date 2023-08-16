
(define-library
  (euphrates gkeyword)
  (export
    gkeyword?
    gkeyword->rkeyword
    gkeyword->fkeyword)
  (import (only (euphrates fkeyword) fkeyword?))
  (import (only (euphrates rkeyword) rkeyword?))
  (import
    (only (scheme base)
          -
          begin
          define
          if
          let
          or
          string->symbol
          string-append
          string-length
          substring
          symbol->string))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/gkeyword.scm")))
    (else (include "gkeyword.scm"))))
