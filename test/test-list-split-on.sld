
(define-library
  (test-list-split-on)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-split-on) list-split-on))
  (import
    (only (scheme base)
          begin
          cond-expand
          even?
          let
          list
          not
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-split-on.scm")))
    (else (include "test-list-split-on.scm"))))
