
(define-library
  (test-number-list)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates fp) fp)
    (only (euphrates number-list)
          number->number-list
          number-list->number)
    (only (scheme base)
          begin
          define-values
          let
          quote)
    (only (scheme r5rs) exact->inexact))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-number-list.scm")))
    (else (include "test-number-list.scm"))))
