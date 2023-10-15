
(define-library
  (test-list-compare)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates clamp) clamp))
  (import
    (only (scheme base) - begin define lambda list))
  (cond-expand
    (guile (import (only (srfi srfi-67) list-compare)))
    (else (import (only (srfi 67) list-compare))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-compare.scm")))
    (else (include "test-list-compare.scm"))))
