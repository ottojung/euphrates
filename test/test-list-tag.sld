
(define-library
  (test-list-tag)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates list-tag) list-tag list-untag)
    (only (scheme base)
          begin
          car
          even?
          let
          map
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-list-tag.scm")))
    (else (include "test-list-tag.scm"))))
