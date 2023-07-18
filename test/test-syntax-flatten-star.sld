
(define-library
  (test-syntax-flatten-star)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates syntax-flatten-star)
          syntax-flatten*))
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
             (include-from-path
               "test-syntax-flatten-star.scm")))
    (else (include "test-syntax-flatten-star.scm"))))
