
(define-library
  (test-letin)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates letin) letin)
    (only (scheme base) + begin do let values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-letin.scm")))
    (else (include "test-letin.scm"))))
