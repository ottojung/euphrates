
(define-library
  (test-fn-pair)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates fn-pair) fn-pair))
  (import
    (only (euphrates list-zip-with) list-zip-with))
  (import (only (euphrates range) range))
  (import
    (only (scheme base)
          *
          +
          begin
          cond-expand
          cons
          map
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-fn-pair.scm")))
    (else (include "test-fn-pair.scm"))))
