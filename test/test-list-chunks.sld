
(define-library
  (test-list-chunks)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates list-chunks) list-chunks)
    (only (scheme base) begin let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-chunks.scm")))
    (else (include "test-list-chunks.scm"))))
