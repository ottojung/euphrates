
(define-library
  (euphrates list-consume)
  (export list-consume)
  (import
    (only (euphrates list-reduce-pairwise)
          list-reduce/pairwise))
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
               "euphrates/list-consume.scm")))
    (else (include "list-consume.scm"))))
