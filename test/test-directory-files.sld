
(define-library
  (test-directory-files)
  (import
    (only (euphrates assert-equal-hs) assert=HS))
  (import
    (only (euphrates directory-files)
          directory-files))
  (import
    (only (scheme base) begin cond-expand quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-directory-files.scm")))
    (else (include "test-directory-files.scm"))))
