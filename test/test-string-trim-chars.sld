
(define-library
  (test-string-trim-chars)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates string-trim-chars)
          string-trim-chars))
  (import
    (only (scheme base)
          begin
          cond-expand
          define
          let*
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-string-trim-chars.scm")))
    (else (include "test-string-trim-chars.scm"))))
