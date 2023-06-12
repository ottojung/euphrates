
(define-library
  (test-syntax-append)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates syntax-append) syntax-append)
    (only (scheme base)
          _
          begin
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
