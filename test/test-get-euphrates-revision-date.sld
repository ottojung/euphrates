
(define-library
  (test-get-euphrates-revision-date)
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates get-euphrates-revision-date)
          get-euphrates-revision-date))
  (import (only (scheme base) begin not string?))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-null?)))
    (else (import (only (srfi 13) string-null?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-get-euphrates-revision-date.scm")))
    (else (include "test-get-euphrates-revision-date.scm"))))
