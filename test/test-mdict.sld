
(define-library
  (test-mdict)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates assert) assert)
    (only (euphrates mdict)
          mdict
          mdict-has?
          mdict-set!)
    (only (scheme base) begin let not))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-mdict.scm")))
    (else (include "test-mdict.scm"))))
