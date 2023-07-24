
(define-library
  (test-profun-eval-query-terms)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates profun-eval-query-terms)
          profun-eval-query/terms))
  (import
    (only (euphrates profun-standard-handler)
          profun-standard-handler))
  (import
    (only (euphrates profun) profun-create-database))
  (import
    (only (scheme base)
          begin
          cond-expand
          define
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-profun-eval-query-terms.scm")))
    (else (include "test-profun-eval-query-terms.scm"))))
