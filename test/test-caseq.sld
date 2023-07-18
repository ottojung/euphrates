
(define-library
  (test-caseq)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates caseq) caseq))
  (import
    (only (scheme base)
          begin
          cond-expand
          else
          let
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-caseq.scm")))
    (else (include "test-caseq.scm"))))
