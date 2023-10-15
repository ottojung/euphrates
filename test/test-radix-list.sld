
(define-library
  (test-radix-list)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates fp) fp))
  (import
    (only (euphrates radix-list)
          number->radix-list
          radix-list->number))
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
             (include-from-path "test-radix-list.scm")))
    (else (include "test-radix-list.scm"))))
