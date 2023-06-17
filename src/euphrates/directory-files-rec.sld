
(define-library
  (euphrates directory-files-rec)
  (export directory-files-rec)
  (import
    (only (euphrates directory-files-depth-iter)
          directory-files-depth-iter))
  (import
    (only (scheme base)
          begin
          case
          cond-expand
          cons
          define
          else
          if
          lambda
          let
          map
          quote
          reverse))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/directory-files-rec.scm")))
    (else (include "directory-files-rec.scm"))))
