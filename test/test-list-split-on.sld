
(define-library
  (test-list-split-on)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates list-split-on) list-split-on)
    (only (scheme base) begin even? let list quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-split-on.scm")))
    (else (include "test-list-split-on.scm"))))
