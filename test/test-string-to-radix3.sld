
(define-library
  (test-string-to-radix3)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates radix3-to-string)
          radix3->string))
  (import
    (only (euphrates string-to-radix3)
          string->radix3))
  (import
    (only (scheme base)
          +
          -
          begin
          define
          for-each
          lambda
          quote))
  (cond-expand
    (guile (import (only (srfi srfi-1) iota)))
    (else (import (only (srfi 1) iota))))
  (cond-expand
    (guile (import (only (srfi srfi-64) test-error)))
    (else (import (only (srfi 64) test-error))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-string-to-radix3.scm")))
    (else (include "test-string-to-radix3.scm"))))
