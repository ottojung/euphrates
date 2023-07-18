
(define-library
  (test-number-list)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates fp) fp))
  (import
    (only (euphrates number-list)
          number->number-list
          number-list->number))
  (import
    (only (scheme base)
          begin
          cond-expand
          define-values
          let
          quote))
  (import (only (scheme r5rs) exact->inexact))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-number-list.scm")))
    (else (include "test-number-list.scm"))))
