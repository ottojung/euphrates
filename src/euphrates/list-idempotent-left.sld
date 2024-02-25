
(define-library
  (euphrates list-idempotent-left)
  (export list-idempotent/left)
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
               "euphrates/list-idempotent-left.scm")))
    (else (include "list-idempotent-left.scm"))))
