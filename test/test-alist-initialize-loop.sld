
(define-library
  (test-alist-initialize-loop)
  (import
    (only (euphrates alist-initialize-loop)
          alist-initialize-loop))
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (scheme base)
          *
          begin
          cond-expand
          let
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-alist-initialize-loop.scm")))
    (else (include "test-alist-initialize-loop.scm"))))
