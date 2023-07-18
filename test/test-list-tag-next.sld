
(define-library
  (test-list-tag-next)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-tag-next)
          list-tag/next
          list-untag/next))
  (import
    (only (scheme base)
          begin
          car
          cond-expand
          even?
          let
          map
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-tag-next.scm")))
    (else (include "test-list-tag-next.scm"))))
