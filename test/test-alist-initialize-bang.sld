
(define-library
  (test-alist-initialize-bang)
  (import
    (only (euphrates alist-initialize-bang)
          alist-initialize!
          alist-initialize!:return-multiple
          alist-initialize!:stop)
    (only (euphrates assert-equal) assert=)
    (only (scheme base)
          *
          +
          begin
          define
          let
          or
          quasiquote
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-alist-initialize-bang.scm")))
    (else (include "test-alist-initialize-bang.scm"))))
