
(define-library
  (euphrates list-idempotent)
  (export list-idempotent)
  (import (only (euphrates debug) debug))
  (import
    (only (euphrates list-reduce-pairwise-left)
          list-reduce/pairwise/left))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          begin
          cond
          define
          else
          equal?
          if
          lambda
          list
          quote
          reverse
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-idempotent.scm")))
    (else (include "list-idempotent.scm"))))
