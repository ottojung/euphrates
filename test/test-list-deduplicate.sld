
(define-library
  (test-list-deduplicate)
  (import
    (only (euphrates assert-equal-hs) assert=HS)
    (only (euphrates list-deduplicate)
          list-deduplicate)
    (only (scheme base) begin let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-deduplicate.scm")))
    (else (include "test-list-deduplicate.scm"))))
