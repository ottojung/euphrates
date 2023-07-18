
(define-library
  (test-mdict)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates mdict)
          mdict
          mdict-has?
          mdict-set!))
  (import
    (only (scheme base) begin cond-expand let not))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-mdict.scm")))
    (else (include "test-mdict.scm"))))
