
(define-library
  (test-alist-initialize-bang)
  (import
    (only (euphrates alist-initialize-bang)
          alist-initialize!
          alist-initialize!:return-multiple
          alist-initialize!:stop
          alist-initialize!:unset))
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (scheme base)
          *
          +
          begin
          cond-expand
          define
          let
          not
          or
          quasiquote
          quote
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-alist-initialize-bang.scm")))
    (else (include "test-alist-initialize-bang.scm"))))
