
(define-library
  (test-url-goto)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates url-goto) url-goto))
  (import
    (only (scheme base) begin cond-expand let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-url-goto.scm")))
    (else (include "test-url-goto.scm"))))
