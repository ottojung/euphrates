
(define-library
  (test-url-decompose)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates url-decompose) url-decompose)
    (only (scheme base)
          begin
          define
          define-values
          vector))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-url-decompose.scm")))
    (else (include "test-url-decompose.scm"))))
