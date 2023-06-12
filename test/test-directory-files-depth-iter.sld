
(define-library
  (test-directory-files-depth-iter)
  (import
    (only (euphrates assert-equal-hs) assert=HS)
    (only (euphrates directory-files-depth-iter)
          directory-files-depth-iter)
    (only (scheme base)
          begin
          cons
          define
          if
          let
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-directory-files-depth-iter.scm")))
    (else (include "test-directory-files-depth-iter.scm"))))
