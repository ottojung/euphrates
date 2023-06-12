
(define-library
  (test-url-goto)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates url-goto) url-goto)
    (only (scheme base) begin let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-url-goto.scm")))
    (else (include "test-url-goto.scm"))))
