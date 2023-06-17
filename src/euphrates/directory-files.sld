
(define-library
  (euphrates directory-files)
  (export directory-files)
  (import
    (only (euphrates directory-files-depth-iter)
          directory-files-depth-iter))
  (import
    (only (scheme base)
          begin
          cadr
          car
          cdr
          cond-expand
          cons
          define
          if
          lambda
          let
          let-values
          list
          map
          not
          quote
          unless))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (ice-9 ftw))
           (begin
             (include-from-path
               "euphrates/directory-files.scm")))
    (else (include "directory-files.scm"))))
