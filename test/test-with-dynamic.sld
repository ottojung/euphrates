
(define-library
  (test-with-dynamic)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates lazy-parameter) lazy-parameter)
    (only (euphrates tilda-a) ~a)
    (only (euphrates with-dynamic) with-dynamic)
    (only (scheme base)
          begin
          define
          lambda
          make-parameter
          set!
          string->number))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-with-dynamic.scm")))
    (else (include "test-with-dynamic.scm"))))
