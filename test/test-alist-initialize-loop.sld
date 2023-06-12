
(define-library
  (test-alist-initialize-loop)
  (import
    (only (euphrates alist-initialize-loop)
          alist-initialize-loop)
    (only (euphrates assert-equal) assert=)
    (only (scheme base) * begin let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-alist-initialize-loop.scm")))
    (else (include "test-alist-initialize-loop.scm"))))
