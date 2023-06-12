
(define-library
  (test-list-break)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates list-break) list-break)
    (only (scheme base)
          begin
          define-values
          even?
          let
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-list-break.scm")))
    (else (include "test-list-break.scm"))))
