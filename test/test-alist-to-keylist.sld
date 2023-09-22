
(define-library
  (test-alist-to-keylist)
  (import
    (only (euphrates alist-to-keylist)
          alist->keylist))
  (import (only (euphrates assert-equal) assert=))
  (import (only (scheme base) begin list quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-alist-to-keylist.scm")))
    (else (include "test-alist-to-keylist.scm"))))
