
(define-library
  (test-random-variable-name)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates random-variable-name)
          random-variable-name))
  (import
    (only (scheme base)
          begin
          cond-expand
          define
          let
          string-length))
  (import (only (scheme char) string-downcase))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-random-variable-name.scm")))
    (else (include "test-random-variable-name.scm"))))
