
(define-library
  (test-syntax-append)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates syntax-append) syntax-append))
  (import
    (only (scheme base)
          _
          begin
          cond-expand
          define-syntax
          let
          list
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-syntax-append.scm")))
    (else (include "test-syntax-append.scm"))))
