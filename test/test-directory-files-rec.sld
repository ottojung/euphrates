
(define-library
  (test-directory-files-rec)
  (import
    (only (euphrates assert-equal-hs) assert=HS))
  (import
    (only (euphrates directory-files-rec)
          directory-files-rec))
  (import
    (only (scheme base) begin cond-expand let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-directory-files-rec.scm")))
    (else (include "test-directory-files-rec.scm"))))
