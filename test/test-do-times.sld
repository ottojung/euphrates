
(define-library
  (test-do-times)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates do-times) do-times))
  (import
    (only (scheme base) * begin define let set!))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-do-times.scm")))
    (else (include "test-do-times.scm"))))
