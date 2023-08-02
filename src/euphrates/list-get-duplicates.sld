
(define-library
  (euphrates list-get-duplicates)
  (export list-get-duplicates)
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates list-group-by) list-group-by))
  (import
    (only (scheme base)
          begin
          cdr
          define
          map
          not
          null?))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-get-duplicates.scm")))
    (else (include "list-get-duplicates.scm"))))
