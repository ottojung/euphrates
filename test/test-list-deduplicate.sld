
(define-library
  (test-list-deduplicate)
  (import
    (only (euphrates assert-equal-hs) assert=HS))
  (import
    (only (euphrates list-deduplicate)
          list-deduplicate))
  (import
    (only (scheme base) begin cond-expand let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-deduplicate.scm")))
    (else (include "test-list-deduplicate.scm"))))
