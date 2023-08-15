
(define-library
  (test-fkeyword)
  (import
    (only (euphrates assert-throw) assert-throw))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates fkeyword)
          fkeyword->string
          looks-like-an-unquoted-fkeyword?
          string->fkeyword))
  (import
    (only (scheme base) begin eq? not quote string=?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-fkeyword.scm")))
    (else (include "test-fkeyword.scm"))))
