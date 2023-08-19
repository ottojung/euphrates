
(define-library
  (test-list-mark-ends)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-mark-ends) list-mark-ends))
  (import (only (scheme base) begin quote))
  (cond-expand
    (guile (import (only (srfi srfi-1) iota)))
    (else (import (only (srfi 1) iota))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-mark-ends.scm")))
    (else (include "test-list-mark-ends.scm"))))
