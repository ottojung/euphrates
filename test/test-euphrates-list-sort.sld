
(define-library
  (test-euphrates-list-sort)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates euphrates-list-sort)
          euphrates:list-sort))
  (import
    (only (scheme base) < begin lambda modulo quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-euphrates-list-sort.scm")))
    (else (include "test-euphrates-list-sort.scm"))))
