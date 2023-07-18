
(define-library
  (test-fn-alist)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates fn-alist) fn-alist))
  (import
    (only (scheme base)
          +
          begin
          cond-expand
          define
          quasiquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-fn-alist.scm")))
    (else (include "test-fn-alist.scm"))))
