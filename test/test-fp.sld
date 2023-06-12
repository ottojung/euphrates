
(define-library
  (test-fp)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates fp) fp)
    (only (euphrates list-zip-with) list-zip-with)
    (only (euphrates range) range)
    (only (scheme base) * + begin let list map quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-fp.scm")))
    (else (include "test-fp.scm"))))
