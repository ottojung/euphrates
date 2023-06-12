
(define-library
  (test-random-variable-name)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates random-variable-name)
          random-variable-name)
    (only (scheme base)
          begin
          define
          let
          string-length)
    (only (scheme char) string-downcase))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-random-variable-name.scm")))
    (else (include "test-random-variable-name.scm"))))
