
(define-library
  (test-list-chunks)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-chunks) list-chunks))
  (import
    (only (scheme base) begin cond-expand let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-chunks.scm")))
    (else (include "test-list-chunks.scm"))))
