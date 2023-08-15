
(define-library
  (test-rkeyword)
  (import
    (only (euphrates assert-throw) assert-throw))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates rkeyword)
          looks-like-an-unquoted-rkeyword?
          rkeyword->string
          string->rkeyword))
  (import
    (only (scheme base) begin eq? not quote string=?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-rkeyword.scm")))
    (else (include "test-rkeyword.scm"))))
