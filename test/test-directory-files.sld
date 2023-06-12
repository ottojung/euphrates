
(define-library
  (test-directory-files)
  (import
    (only (euphrates assert-equal-hs) assert=HS)
    (only (euphrates directory-files)
          directory-files)
    (only (scheme base) begin quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-directory-files.scm")))
    (else (include "test-directory-files.scm"))))
