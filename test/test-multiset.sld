
(define-library
  (test-multiset)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates multiset)
          list->multiset
          make-multiset
          multiset->list))
  (import
    (only (scheme base) begin equal? list not quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-multiset.scm")))
    (else (include "test-multiset.scm"))))
