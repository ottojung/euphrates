
(define-library
  (test-list-collapse)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-collapse) list-collapse))
  (import (only (scheme base) begin quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-collapse.scm")))
    (else (include "test-list-collapse.scm"))))
