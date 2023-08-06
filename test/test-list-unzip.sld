
(define-library
  (test-list-unzip)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates list-unzip) list-unzip))
  (import
    (only (scheme base)
          begin
          call-with-values
          define
          lambda
          list
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-list-unzip.scm")))
    (else (include "test-list-unzip.scm"))))
