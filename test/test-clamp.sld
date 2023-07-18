
(define-library
  (test-clamp)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates clamp) clamp))
  (import (only (scheme base) begin cond-expand))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-clamp.scm")))
    (else (include "test-clamp.scm"))))
