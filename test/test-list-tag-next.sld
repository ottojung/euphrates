
(define-library
  (test-list-tag-next)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates list-tag-next)
          list-tag/next
          list-untag/next)
    (only (scheme base)
          begin
          car
          even?
          let
          map
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-tag-next.scm")))
    (else (include "test-list-tag-next.scm"))))
