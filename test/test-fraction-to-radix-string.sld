
(define-library
  (test-fraction-to-radix-string)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates fraction-to-radix-string)
          fraction->radix-string))
  (import
    (only (scheme base)
          *
          /
          begin
          define
          number->string
          string->number
          vector))
  (import (only (scheme r5rs) exact->inexact))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-prefix?)))
    (else (import (only (srfi 13) string-prefix?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-fraction-to-radix-string.scm")))
    (else (include "test-fraction-to-radix-string.scm"))))
