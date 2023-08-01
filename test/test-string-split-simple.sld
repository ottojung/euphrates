
(define-library
  (test-string-split-simple)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates string-split-simple)
          string-split/simple))
  (import
    (only (scheme base)
          begin
          cond-expand
          let
          not
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-string-split-simple.scm")))
    (else (include "test-string-split-simple.scm"))))
