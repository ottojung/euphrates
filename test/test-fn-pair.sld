
(define-library
  (test-fn-pair)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates fn-pair) fn-pair)
    (only (euphrates list-zip-with) list-zip-with)
    (only (euphrates range) range)
    (only (scheme base) * + begin cons map quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-fn-pair.scm")))
    (else (include "test-fn-pair.scm"))))
