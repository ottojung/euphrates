
(define-library
  (test-alist-initialize-bang)
  (import
    (only (euphrates alist-initialize-bang)
          alist-initialize!
          alist-initialize!:return-multiple
          alist-initialize!:stop))
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (scheme base)
          *
          +
          begin
          cond-expand
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
