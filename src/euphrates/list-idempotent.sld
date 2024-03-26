
(define-library
  (euphrates list-idempotent)
  (export list-idempotent)
  (import
    (only (euphrates list-reduce-pairwise-left)
          list-reduce/pairwise/left))
  (import
    (only (scheme base)
          begin
          define
          if
          lambda
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-idempotent.scm")))
    (else (include "list-idempotent.scm"))))
