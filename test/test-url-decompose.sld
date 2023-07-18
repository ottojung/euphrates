
(define-library
  (test-url-decompose)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates url-decompose) url-decompose))
  (import
    (only (scheme base)
          begin
          cond-expand
          define
          define-values
          vector))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-url-decompose.scm")))
    (else (include "test-url-decompose.scm"))))
