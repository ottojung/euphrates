
(define-library
  (test-list-partition)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates list-partition) list-partition)
    (only (euphrates range) range)
    (only (scheme base) begin even? let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-partition.scm")))
    (else (include "test-list-partition.scm"))))
