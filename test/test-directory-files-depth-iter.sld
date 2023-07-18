
(define-library
  (test-directory-files-depth-iter)
  (import
    (only (euphrates assert-equal-hs) assert=HS))
  (import
    (only (euphrates directory-files-depth-iter)
          directory-files-depth-iter))
  (import
    (only (scheme base)
          begin
          cond-expand
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
