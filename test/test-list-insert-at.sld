
(define-library
  (test-list-insert-at)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-insert-at) list-insert-at))
  (import
    (only (scheme base) begin cond-expand let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-insert-at.scm")))
    (else (include "test-list-insert-at.scm"))))
