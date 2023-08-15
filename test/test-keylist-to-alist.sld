
(define-library
  (test-keylist-to-alist)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates keylist-to-alist)
          keylist->alist))
  (import
    (only (scheme base) begin equal? list quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-keylist-to-alist.scm")))
    (else (include "test-keylist-to-alist.scm"))))
