
(define-library
  (test-list-partition)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-partition) list-partition))
  (import (only (euphrates range) range))
  (import
    (only (scheme base)
          begin
          cond-expand
          even?
          let
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-partition.scm")))
    (else (include "test-list-partition.scm"))))
