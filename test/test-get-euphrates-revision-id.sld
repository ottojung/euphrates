
(define-library
  (test-get-euphrates-revision-id)
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates get-euphrates-revision-id)
          get-euphrates-revision-id))
  (import (only (scheme base) begin not string?))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-null?)))
    (else (import (only (srfi 13) string-null?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-get-euphrates-revision-id.scm")))
    (else (include "test-get-euphrates-revision-id.scm"))))
