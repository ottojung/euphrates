
(define-library
  (test-list-break)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates list-break) list-break))
  (import
    (only (scheme base)
          begin
          cond-expand
          define-values
          even?
          let
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-list-break.scm")))
    (else (include "test-list-break.scm"))))
