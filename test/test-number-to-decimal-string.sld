
(define-library
  (test-number-to-decimal-string)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates number-to-decimal-string)
          number->decimal-string))
  (import
    (only (scheme base)
          *
          /
          begin
          number->string
          string->number))
  (import (only (scheme r5rs) exact->inexact))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-prefix?)))
    (else (import (only (srfi 13) string-prefix?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-number-to-decimal-string.scm")))
    (else (include "test-number-to-decimal-string.scm"))))
