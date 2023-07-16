
(define-library
  (test-list-zip-longest)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-zip-longest)
          list-zip-longest))
  (import
    (only (scheme base) begin define let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-zip-longest.scm")))
    (else (include "test-list-zip-longest.scm"))))
