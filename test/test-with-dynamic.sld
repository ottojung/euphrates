
(define-library
  (test-with-dynamic)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates lazy-parameter) lazy-parameter))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (euphrates with-dynamic) with-dynamic))
  (import
    (only (scheme base)
          begin
          cond-expand
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
